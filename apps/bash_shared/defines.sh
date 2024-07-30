unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
   if ! command -v brew &>/dev/null ; then
       ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   fi
   if ! [ "${BASH_VERSINFO}" -ge 4 ]; then
       brew install bash
   fi
   if ! command -v greadlink &>/dev/null ; then
       brew install coreutils
   fi
   TC_PATH_ROOT=$(greadlink -f "$TC_PATH_APPS/../")
else
   TC_PATH_ROOT=$(readlink -f "$TC_PATH_APPS/../")
fi

case $TC_PATH_ROOT in
  /*) TC_PATH_ROOT=$TC_PATH_ROOT;;
  *) TC_PATH_ROOT=$PWD/$TC_PATH_ROOT;;
esac

TC_PATH_CONF="$TC_PATH_ROOT/conf"

TC_PATH_MODULES="$TC_PATH_ROOT/modules"

TC_PATH_DEPS="$TC_PATH_ROOT/deps"

TC_PATH_VAR="$TC_PATH_ROOT/var"
