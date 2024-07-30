CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../../bash_shared/includes.sh"

AC_PATH_COMPILER="$TC_PATH_APPS/compiler"

if [ -f "$TC_PATH_COMPILER/config.sh"  ]; then
    source "$TC_PATH_COMPILER/config.sh" # should overwrite previous
fi

function tc_on_after_build() {
    # move the run engine
    cp -rvf "$TC_PATH_APPS/startup-scripts/"* "$BINPATH"
}

registerHooks "ON_AFTER_BUILD" tc_on_after_build

source "$TC_PATH_COMPILER/includes/defines.sh"

source "$TC_PATH_COMPILER/includes/functions.sh"

mkdir -p $BUILDPATH
mkdir -p $BINPATH
