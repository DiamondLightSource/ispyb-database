#!/usr/bin/bash

# Fail on unset variables
set -u

#
# Assumptions - adapt as needed to your environment:
#
# - /mnt/snapshot/ exists
# - The user running the script has relevant password-less sudo permissions
# - The volume group is called VolGroup00
# - The source logical volume name is called varlibmysql
# - The snapshot logical volume name is called mariadb-backup

# Arguments:
#
# 1: Path to the final destination directory
#

export DEST_DIR="${1:?arg not defined}"
export LVM_SUPPRESS_FD_WARNINGS=1

# Make sure the destination directory exists and has a unique subdir
export DEST_DIR_SUB="${DEST_DIR:?not defined}"/$(date +%Y-%m-%d_%H%M%S-%A)
mkdir "${DEST_DIR_SUB:?not defined}"/

# The following lines are run from inside the mariadb client. The reason is
# that the MariaDB "BACKUP STAGE" commands need to all run inside the same
# connection, and the BACKUP STAGE END command needs to run after the lvcreate
# command.

# shellcheck disable=SC2016
mariadb -e '
-- Ensure that all non-transactional tables are properly flushed to disk before
-- the snapshot is done. Using BACKUP STAGE commands is also more efficient than
-- using the FLUSH TABLES WITH READ LOCK command as this set of commands
-- will not block or be blocked by write operations to transactional tables.
BACKUP STAGE START;
BACKUP STAGE BLOCK_COMMIT;

-- When using the LVM backup to set up a replication slave, we need to
-- know the current replication position, so write this to a text file
-- in case we need it later:
system echo $(mariadb -Nse "SELECT @@global.gtid_binlog_pos") > ${DEST_DIR_SUB}/gtid_binlog_pos.txt

-- Create the actual snapshot
system sudo /usr/sbin/lvcreate -l100%FREE -s -n mariadb-backup /dev/VolGroup00/varlibmysql

-- Complete the backup stage
BACKUP STAGE END;'

# Copy the snapshot to other server/disk
sudo mount /dev/VolGroup00/mariadb-backup /mnt/snapshot -o nouuid -t xfs
sudo cp -pr /mnt/snapshot "${DEST_DIR_SUB:?not defined}"/.

# Dispose of the snapshot
sudo umount /mnt/snapshot
sudo /usr/sbin/lvremove --yes /dev/VolGroup00/mariadb-backup
