#!/usr/bin/env bash

# This script assumes a MariaDB Galera Cluster with read-write split. The
# script must be run locally on one of the database read nodes.
#
# Note that the node is desynced from the cluster (wsrep_desync=ON) while
# mariabackup is running, meaning that flow control is disabled. This allows
# the node to fall behind the cluster. Therefore the node will not necessarily
# be up-to-date with changes written to the cluster.
#
# Note also that the prepare_host needs to have mariabackup installed.
#
# Author: Karl Levik, Diamond Light Source
# Date: 2020-10-20
#

while [ $# -gt 0 ]; do
  case "$1" in
    --backup_root_dir=*)
      backup_root_dir="${1#*=}"
      ;;
    --dest_dir=*)
      dest_dir="${1#*=}"
      ;;
    --credentials_file=*)
      credentials_file="${1#*=}"
      ;;
    --socket=*)
      socket="${1#*=}"
      ;;
    --dbproxy_host=*)
      dbproxy_host="${1#*=}"
      ;;
    --dbproxy_off_cmd=*)
      dbproxy_off_cmd="${1#*=}"
      ;;
    --dbproxy_on_cmd=*)
      dbproxy_on_cmd="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

today=$(date +%Y-%m-%d-%A)
backup_dir=${backup_root_dir}/${today} 
hostname=$(hostname -s)

# Remove old backups - last run already copied these to ${dest_dir}
rm -rf "${backup_root_dir:?}"/*

# Make sure backup directory exists
mkdir -p "${backup_dir:?}"

# Label node as 'in maintenance' in dbproxy
ssh "${dbproxy_host}" "${dbproxy_off_cmd}"

# Desync the node
# You need (at least one of) the SUPER privilege(s) for this operation
mariadb --defaults-group-suffix="${hostname}" -u root -e "SET GLOBAL wsrep_desync=ON;"

# Make full backup i.e. all the databases
mariabackup --defaults-extra-file="${credentials_file}" --backup --socket="${socket}" --no-lock --parallel=8 --log-innodb-page-corruption --target-dir="${backup_dir}"

# Prepare the backup
mariabackup --prepare --target-dir="${backup_dir}" --parallel=8 --verbose --innodb-force-recovery=1

# Sync the node again
# You need (at least one of) the SUPER privilege(s) for this operation
mariadb --defaults-group-suffix="${hostname}" -u root -e "SET GLOBAL wsrep_desync=OFF;"

# Clear node 'maintenance' label in dbproxy
ssh "${dbproxy_host}" "${dbproxy_on_cmd}"

fname=dbbackup-"${today}".tar.gz
target_path="${dest_dir}"/"${fname}"

# Compress backup
cd "${backup_root_dir}" || exit
tar cfz "${target_path}" "${today}"

# Remove files in the destination folder that are older than 7 days, except Tuesdays
cd / && find "${dest_dir}"/dbbackup* -type f -mtime +7 ! -name "*Tuesday*" -exec rm -f {} \;

# Remove files in the target folder that are older than 4 weeks
cd / && find "${dest_dir}"/dbbackup* -type f -mtime +28 -exec rm -f {} \;

