#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
SHELL_BIN=$(basename $SHELL)
SHELL_CONFIG=~/".${SHELL_BIN}rc"
CEX_APP_ROOT=$PWD

function create_script
{
    local name="$1"
    local body="$2"

    mkdir -p $(dirname ${name})
    touch $name

    while read line
    do
        echo "${line}" >> ${name}
    done <<< "${body}"

    chmod u+x ${name}
}

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
create_script "${LINK_NAME}" "#!/bin/bash
export CEX_APP_NAME=$CEX_APP_NAME
export CEX_APP_ID=$CEX_APP_ID
export CEX_APP_ROOT=\"\$( cd \"\$(dirname \"\${BASH_SOURCE[0]}\")\" ; pwd -P )\"
\${CEX_APP_ROOT}/$(realpath --relative-to=${PWD} ${SCRIPT_DIR})/cex \$@
"


# Code example
mkdir -p ${CEX_APP_ROOT}/preload

echo -e "HELLO=\"Hello \"
" > ${CEX_APP_ROOT}/preload/hello

echo -e "function world {
    echo \" world!\"
}
" > ${CEX_APP_ROOT}/preload/world

create_script "${CEX_APP_ROOT}/src/hello_world.sh" "#!/bin/bash
echo -n \$HELLO
world
"

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

red='\033[0;31m'
reset='\033[0m'
printf "${red}run:${reset} . $SHELL_CONFIG\\n" 1>&2
echo "run: ${CEX_APP_NAME} --help"
echo "run: ${CEX_APP_NAME} hello-world"

create_script "${CEX_APP_ROOT}/hooks/post_install.sh" "#!/bin/bash
echo "post_install"
"
create_script "${CEX_APP_ROOT}/hooks/pre_install.sh" "#!/bin/bash
echo "pre_install"
"

create_script "${CEX_APP_ROOT}/hooks/pre_uninstall.sh" "#!/bin/bash
echo "pre_uninstall"
"

create_script "${CEX_APP_ROOT}/hooks/post_uninstall.sh" "#!/bin/bash
echo "post_uninstall"
"