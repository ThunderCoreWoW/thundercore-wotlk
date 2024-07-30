[[ ${GUARDYVAR:-} -eq 1 ]] && return || readonly GUARDYVAR=1 # include it once

# force default language for applications
LC_ALL=C

TC_PATH_APPS="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

TC_PATH_SHARED="$TC_PATH_APPS/bash_shared"

source "$TC_PATH_SHARED/defines.sh"

source "$TC_PATH_DEPS/acore/bash-lib/src/event/hooks.sh"

source "$TC_PATH_SHARED/common.sh"

[[ "$OSTYPE" = "msys" ]] && TC_BINPATH_FULL="$BINPATH" || TC_BINPATH_FULL="$BINPATH/bin"
