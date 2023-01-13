#!/usr/bin/env bash
set -ex

# Usage info
show_help()
{
echo "
        Usage: [-v Type]

        -t Type           Type
        -p Build Prefix   prefix
        -d                Displays useful data to debug this script
        -a                Automatic mode. Requires -v parameter to be 100% without prompt
        -s                Same as -a but in silent mode

        -h                Help
"
}
NO_PROMPT=0

while getopts ":t:build-prefix:app-center-group:dhas" opt; do
  case $opt in
    t) TYPE="$OPTARG"
    ;;
    prefix) PREFIX="$OPTARG"
    ;;
    group-name) GROUP_NAME="$OPTARG"
    ;;
    d) set -ex
    ;;
    h) show_help; exit 0
    ;;
    a) NO_PROMPT=1
    ;;
    s) NO_PROMPT=1; exec &>/dev/null
    ;;
    \?) echo "Invalid option -$OPTARG" >&1; exit 1
    ;;
  esac
done


WORK_DIR=$(pwd)
TMP_DIR=$WORK_DIR/tmp

echo "Build Prefix: $PREFIX"
echo "Group Name: $GROUP_NAME"