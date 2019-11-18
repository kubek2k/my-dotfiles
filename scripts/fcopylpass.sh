#!/usr/bin/env bash

BASEDIR="$(dirname $0)"

$BASEDIR/fgetlpass.sh | pbcopy
