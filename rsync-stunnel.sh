#!/usr/bin/env bash

set -e
[ "$DEBUG" == 'true' ] && set -x

: ${RSYNC_SSL_CERT:="/etc/stunnel-rsync/client.crt"}
: ${RSYNC_SSL_CA_CERT:="/etc/stunnel-rsync/ca.crt"}
: ${RSYNC_SSL_KEY:="/etc/stunnel-rsync/client.key"}
: ${RSYNC_SSL_PORT:="8873"}
: ${RSYNC_SSL_HOST:=${1}}
: ${RSYNC_SSL_TIMEOUT:='0'}

CONFIG=$(mktemp -t stunnel-rsync.XXXXXXXXXX)
cat > $CONFIG <<EOF
foreground = yes
connect = ${RSYNC_SSL_HOST}:${RSYNC_SSL_PORT}
client = yes
cert   = ${RSYNC_SSL_CERT}
key    = ${RSYNC_SSL_KEY}
CAfile = ${RSYNC_SSL_CA_CERT}
verify = 2
debug = crit
TIMEOUTclose = ${RSYNC_SSL_TIMEOUT}
EOF

trap 'rm -f "$CONFIG"' EXIT

[ "$DEBUG" == 'true' ] && set +x
stunnel $CONFIG
