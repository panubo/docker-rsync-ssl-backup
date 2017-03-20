#!/usr/bin/env bash

set -e

rsync --rsh $(which rsync-stunnel.sh) "$@"
