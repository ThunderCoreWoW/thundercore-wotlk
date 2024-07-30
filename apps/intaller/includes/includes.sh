[[ ${INSTALLER_GUARDYVAR:-} -eq 1 ]] && return || readonly INSTALLER_GUARDYVAR=1 # include it once

CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd )

source "$CURRENT_PATH/../../bash_shared/includes.sh"

TC_PATH_INSTALLER="$TC_PATH_APPS/installer"

J_PATH="$TC_PATH_DEPS/tcore/joiner"
J_PATH_MODULES="$TC_PATH_MODULES"

source "$J_PATH/joiner.sh"

if [ -f "$TC_PATH_INSTALLER/config.sh"  ]; then
    source "$TC_PATH_INSTALLER/config.sh" # should overwrite previous
fi

source "$TC_PATH_APPS/compiler/includes/includes.sh"

source "$TC_PATH_DEPS/semver_bash/semver.sh"

source "$TC_PATH_INSTALLER/includes/functions.sh"
