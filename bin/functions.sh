function debug {
  if [ "${DEBUG}" = "yes" ]
  then
    echo $1
  fi
}

function error {
  echo $1
  exit 1
}

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

function contains() {
    [[ $1 =~ (^|[[:space:]])"$2"($|[[:space:]]) ]] && return 0 || return 1
}
