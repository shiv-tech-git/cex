#!/bin/bash

cex_check_var CEX_APP_ROOT
cex_check_var CEX_APP_ID

SHELL_BIN=$(basename $SHELL)
SHELL_CONFIG=~/".${SHELL_BIN}rc"

config="PATH=\$PATH:${CEX_APP_ROOT} #$CEX_APP_ID"

if [ "$1" == "--uninstall" ]; then
    #uninstall
    if ! grep -q "$CEX_APP_ID" $SHELL_CONFIG ; then
        echo "Not installed for ${SHELL_BIN}"
        exit 0
    fi

    IFS=$'\n'
    for line in $config ; do
        escaped_line=$(echo $line | sed 's/\//\\\//g') 
        sed -i "/$escaped_line/d" $SHELL_CONFIG
        echo "Remove from $SHELL_CONFIG:"
        echo $config | sed 's/\(.*\)/\t\1/'
        echo
    done
else
    #install
    if grep -q "$CEX_APP_ID" $SHELL_CONFIG ; then
        echo "Already installed for ${SHELL_BIN}"
        exit 0
    fi

    echo "$config" >> $SHELL_CONFIG
    echo -e "Append to $SHELL_CONFIG:"
    echo $config | sed 's/\(.*\)/\t\1/'
    echo
    cex_print_notice "run: . $SHELL_CONFIG"
fi