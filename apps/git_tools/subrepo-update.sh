#!/usr/bin/env bash

#######################
#
# README
#
# This script is used to automatically update
# submodules and subrepos included in this project
# Subrepo are updated in bidirectional way (pull + push)
# because they are intended to be developed by this organization
#
# NOTE: only maintainers and CI should run this script and
# keep it updated
#
#######################

set -e
ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../../"
# update all submodules
git submodule update --init --recursive
git submodule foreach git pull origin master
# include libraries for git subrepo
source "$ROOT_PATH/deps/git-subrepo/.rc"
source "$ROOT_PATH/deps/tcore/bash-lib/src/git-utils/subrepo.sh"

echo "> Pulling and update all subrepos"

subrepoUpdate https://github.com/ThunderCoreWoW/bash-lib  master deps/tcore/bash-lib

subrepoUpdate https://github.com/ThunderCoreWoW/cmake-utils  master deps/tcore/cmake-utils

subrepoUpdate https://github.com/ThunderCoreWoW/mysql-tools  master deps/tcore/mysql-tools

subrepoUpdate https://github.com/ThunderCoreWoW/joiner  master deps/tcore/joiner
