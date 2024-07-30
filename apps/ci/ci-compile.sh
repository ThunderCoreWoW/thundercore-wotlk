#!/bin/bash

set -e

echo "compile core"
export TC_CCACHE=true
./tcore.sh "compiler" "all"

