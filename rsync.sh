#!/usr/bin/env bash

set -e
[ "$DEBUG" == 'true' ] && set -x

rsync --rsh $(which rsync-stunnel.sh) "$@"
