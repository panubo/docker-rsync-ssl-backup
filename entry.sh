#!/usr/bin/env bash

set -e
[ "$DEBUG" == 'true' ] && set -x

echo ">> Rsync SSL backup client started"

die () {
    echo "Error: $@"
    exit 128
}

# Defaults
: ${BACKUP_PATH:="/mnt/data/"}
: ${BACKUP_EXCLUDES:=""}
: ${REMOTE_MODULE:="backup"}
: ${RSYNC_SSL_CERT:="/etc/stunnel-rsync/client.crt"}
: ${RSYNC_SSL_CA_CERT:="/etc/stunnel-rsync/ca.crt"}
: ${RSYNC_SSL_KEY:="/etc/stunnel-rsync/client.key"}
: ${RSYNC_ARGS:="-avHz --numeric-ids --delete --delete-excluded"}

# Sanity checks
[ -z "${REMOTE}" ] && die "REMOTE not set"
[ ! -d "${BACKUP_PATH}" ] && die "BACKUP_PATH: $BACKUP_PATH does not exist set"
[ ! -f "${RSYNC_SSL_CERT}" ] && die "RSYNC_SSL_CERT does not exist set"
[ ! -f "${RSYNC_SSL_CA_CERT}" ] && die "RSYNC_SSL_CA_CERT does not exist set"
[ ! -f "${RSYNC_SSL_KEY}" ] && die "RSYNC_SSL_KEY does not exist set"

# expand excludes
eval 'for E in $BACKUP_EXCLUDES; do RSYNC_EXCLUDES="$RSYNC_EXCLUDES --exclude=${E}"; done'

exec rsync.sh ${RSYNC_ARGS} ${RSYNC_EXCLUDES} ${BACKUP_PATH} ${REMOTE}::${REMOTE_MODULE}
