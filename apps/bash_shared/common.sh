function registerHooks() { acore_event_registerHooks "$@"; }
function runHooks() { acore_event_runHooks "$@"; }

source "$TC_PATH_CONF/dist/config.sh" # include dist to avoid missing conf variables

# first check if it's defined in env, otherwise use the default
USER_CONF_PATH=${USER_CONF_PATH:-"$TC_PATH_CONF/config.sh"}

if [ -f  "$USER_CONF_PATH" ]; then
    source "$USER_CONF_PATH" # should overwrite previous
else
    echo "NOTICE: file <$USER_CONF_PATH> not found, we use default configuration only."
fi

#
# Load modules
#

for entry in "$TC_PATH_MODULES/"*/include.sh
do
    if [ -e "$entry" ]; then
        source "$entry"
    fi
done

ACORE_VERSION=$("$TC_PATH_DEPS/jsonpath/JSONPath.sh" -f "$TC_PATH_ROOT/tcore.json" -b '$.version')
