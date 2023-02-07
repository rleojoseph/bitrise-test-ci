#!/usr/bin/env bash

# Usage info
show_help()
{
echo "
        Usage: [-v Type]

        -t Type           Type
        -p Type           Type
        -prefix   Build Prefix   prefix
        -group-name
        -d                Displays useful data to debug this script
        -a                Automatic mode. Requires -v parameter to be 100% without prompt
        -s                Same as -a but in silent mode

        -h                Help
"
}
NO_PROMPT=0

while getopts ":t:p:prefix:group-name:dhas" opt; do
  case $opt in
    t) TYPE="$OPTARG"
    ;;
    p) PREFIX="$OPTARG"
    ;;
    s) SCHEME="$OPTARG"
    ;;
    g) GROUP_NAME="$OPTARG"
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

stg()
{
  echo "Running in Local Env"
  xcodebuild -scheme "CITesting" -configuration "Debug" -sdk "iphonesimulator" -destination "generic/platform=iOS Simulator" SYMROOT=./builds clean build
}

prod()
{
  xcodebuild -scheme $SCHEME -configuration "Debug" -sdk "iphonesimulator" -destination "generic/platform=iOS Simulator" SYMROOT=./builds clean build
  echo "Running in PROD Env"
}

shopt -s nocasematch
if [[ "$TYPE" == "STG" ]]; then
  stg
else
  prod
fi