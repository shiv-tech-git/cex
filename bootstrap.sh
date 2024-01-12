#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
SHELL_BIN=$(basename $SHELL)
SHELL_CONFIG=~/".${SHELL_BIN}rc"
CEX_APP_ROOT=$PWD


# Define cex app name
read -e -p "App name: " CEX_APP_NAME
CEX_APP_ID="cex_$CEX_APP_NAME"
echo "App id: $CEX_APP_ID"


#Add cex app to shellrc 
if grep -q "$CEX_APP_ID" $SHELL_CONFIG ; then
    echo "Already installed for ${SHELL_BIN}"
    exit 1
fi
config="PATH=\$PATH:${CEX_APP_ROOT} #$CEX_APP_ID"
echo "$config" >> $SHELL_CONFIG
echo -e "Append to $SHELL_CONFIG:"
echo $config | sed 's/\(.*\)/\t\1/'
echo


# Create link
LINK_NAME=${CEX_APP_ROOT}/${CEX_APP_NAME}
echo "Create link: $CEX_APP_NAME"
echo "#!/bin/bash
export CEX_APP_NAME=$CEX_APP_NAME
export CEX_APP_ID=$CEX_APP_ID
export CEX_APP_ROOT="$CEX_APP_ROOT"
$SCRIPT_DIR/cex \$@
" > $LINK_NAME
chmod u+x $LINK_NAME


# Code example
mkdir -p ${CEX_APP_ROOT}/preload

echo -e "HELLO=\"Hello \"
" > ${CEX_APP_ROOT}/preload/hello

echo -e "function world {
    echo \" world!\"
}
" > ${CEX_APP_ROOT}/preload/world

mkdir -p ${CEX_APP_ROOT}/src

echo -e "#!/bin/bash
echo -n \$HELLO
world
" > ${CEX_APP_ROOT}/src/hello_world.sh
chmod u+x ${CEX_APP_ROOT}/src/hello_world.sh

echo -e "## Syntax
##
## '#' comment for "dbs --help"
## '##' comment for this file 
## 
## [COMMAND_NAME] "[COMMAND]"
## --[COMMAND_NAME] reserved for ces commands
##
#Hello world
    hello-world     "./src/hello_world.sh"

## last line" > ${CEX_APP_ROOT}/commands

echo "Create hello_world example"
echo

echo "run: . $SHELL_CONFIG"
echo "run: ${CEX_APP_NAME} --help"
echo "run: ${CEX_APP_NAME} hello-world"