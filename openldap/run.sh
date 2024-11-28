#!/bin/sh

GRACEFUL_SHUTDOWN_CHANNEL="channel"
GLOBAL_VAR_FILE="global.env"

function create_named_pipe(){
    local pipe_name=$1
    if [[ ! -p "$pipe_name" ]]; then
        mkfifo $pipe_name
    fi
}

function replace_env_var(){
    local key=$1
    local value=$2
    sed "s~$key=.*~$key=$value~g" $GLOBAL_VAR_FILE > $GLOBAL_VAR_FILE.tmp
    mv -f $GLOBAL_VAR_FILE.tmp $GLOBAL_VAR_FILE
}

function get_env_var(){
    local key=$1
    grep "$key=" $GLOBAL_VAR_FILE  | cut -d'=' -f2
}

function cancel_context() {
    replace_env_var "CONTEXT_DONE" "true"
}

function _term() {
    echo "Caught SIGTERM signal!"
    cancel_context
    kill -INT $(cat /run/slapd.pid)
    echo "Process was gracefully shutdown"
}

function consumer_job() {
    /sbin/slapadd -n 0 -F /etc/slapd.d -l /etc/openldap/slapd.ldif
    /libexec/slapd -F /etc/slapd.d -d 256
}

function main() {
    cat <<EOF > $GLOBAL_VAR_FILE
CONTEXT_DONE=false
EOF
    create_named_pipe $GRACEFUL_SHUTDOWN_CHANNEL
    consumer_job &
    while read -r signal; do
        _term
    done < $GRACEFUL_SHUTDOWN_CHANNEL
}

trap _term SIGTERM
main