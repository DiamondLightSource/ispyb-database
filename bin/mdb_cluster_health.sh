#!/usr/bin/env bash

function colour {
  echo $'\033[1;32m'$1$'\033[00m' 
}

while [ $# -gt 0 ]; do
  case "$1" in
    --os_user=*)
      os_user="${1#*=}"
      ;;
    --credentials_file=*)
      credentials_file="${1#*=}"
      ;;
    --dbproxy_host=*)
      dbproxy_host="${1#*=}"
      ;;
    *)
      echo "Error: Invalid argument."
      exit 1
  esac
  shift
done

[ -z "$os_user" ] && os_user=${USER}

[ -n "$credentials_file" ] && {
  [ -f "$credentials_file" ] || { echo \
    "File '$credentials_file' does not exist"; exit 1; }
}

[ -z "$credentials_file" ] && [ -f "~/.my.cnf" ] && credentials_file="~/.my.cnf"

# Get IP addresses for nodes in cluster according to wsrep_cluster_address system variable
wsrep_cluster_address=$(mariadb --defaults-extra-file="${credentials_file}" -B \
  --skip-column-names -e "SHOW VARIABLES LIKE 'wsrep_cluster_address'")
# The string will just contain "wsrep_cluster_address" (22 chars) if Galera is not enabled 
if [ ${#wsrep_cluster_address} -le 22 ]; then
  echo "No value found for MariaDB system variable wsrep_cluster_address - are we really connecting a MariaDB Galera Cluster node?"
  exit 0
fi

# Get just the IP addresses (these are comma-separated) 
ip_list=$(echo $wsrep_cluster_address | cut -d' ' -f2 | cut -c9-)

# Turn into array
IFS=',' read -ra ip_arr <<< "$ip_list"
unset IFS

echo "MariaDB hosts:"

# Print each IP in the array
ip_count=0
for ip in "${ip_arr[@]}"
do
    ip_count=$(expr ${ip_count} + 1)
    line=$(ssh -l ${os_user} ${ip} mariadb --skip-column-names -e $( printf \
      "%q" "SELECT @@hostname, concat('datadir: ', @@datadir), JSON_OBJECTAGG(lower(VARIABLE_NAME), lower(VARIABLE_VALUE)) FROM information_schema.GLOBAL_STATUS WHERE VARIABLE_NAME IN ('UPTIME', 'THREADS_CONNECTED', 'Max_used_connections', 'Max_statement_time_exceeded') GROUP BY 1, 2;" ))
    echo "  ${line}"
done

if [ -n "$dbproxy_host" ]; then

echo
echo "MaxScale:"

host_output=$(host -t CNAME ${dbproxy_host})

# Handle: 
# - cs04r-sc-vserv-162.diamond.ac.uk has no CNAME record
# - ispybdbproxy.diamond.ac.uk is an alias for cs04r-sc-vserv-162.diamond.ac.uk.  <-- NOTE trailing dot

# Read username and password from ~/.maxctrl.cnf file and run:
mxs_user=$(ssh -l ${os_user} ${dbproxy_host} grep user .maxctrl.cnf)
mxs_user=$(echo ${mxs_user} | tr -d "= " | cut -c5-)
mxs_pw=$(ssh -l ${os_user} ${dbproxy_host} grep password .maxctrl.cnf)
mxs_pw=$(echo ${mxs_pw} | tr -d "= " | cut -c9-)

maxctrl_out=$(ssh -l ${os_user} ${dbproxy_host} maxctrl -u ${mxs_user} -p ${mxs_pw} --tsv list servers)
# echo with indentation
echo "  ${maxctrl_out//$'\n'/$'\n'  }"

# Read credentials from ~/.maxctrl.cnf file and run:
# maxctrl -u $USER -p $PW list servers 


fi

echo
echo "Cluster:"

# Get values for WSREP health status variables
wsrep_status=$(mariadb --defaults-extra-file="${credentials_file}" -B \
  --skip-column-names -e \
  "SHOW STATUS WHERE variable_name IN ('wsrep_ready', 'wsrep_local_state_comment', 'wsrep_connected', 'wsrep_cluster_size', 'wsrep_cluster_status');")

# Parse and print the keys + values - green/red colour for good/bad values
IFS=$'\t'
while read -r k v; do
  case ${k} in 
  wsrep_local_state_comment)
     [ "${v}" == "Synced" ] && v_col=$(colour $v 32m) || v_col=$(colour $v 31m)
     echo "  ${k}: ${v_col}"
     ;;
  wsrep_cluster_size)
     [ ${v} -eq $ip_count ] && v_col=$(colour $v 32m) || v_col=$(colour $v 31m)
     echo "  ${k}: ${v_col}"
     ;;
  wsrep_connected)
     [ "${v}" == "ON" ] && v_col=$(colour $v 32m) || v_col=$(colour $v 31m)
     echo "  ${k}: ${v_col}"
     ;;
  wsrep_ready)
     [ "${v}" == "ON" ] && v_col=$(colour $v 32m) || v_col=$(colour $v 31m)
     echo "  ${k}: ${v_col}"
     ;;
   wsrep_cluster_status)
      [ "${v}" == "Primary" ] && v_col=$(colour $v 32m) || v_col=$(colour $v 31m)
      echo "  ${k}: ${v_col}"
      ;;
  *)
     echo "  ${k}: ${v}"
  esac
done <<< "$wsrep_status" 
unset IFS
