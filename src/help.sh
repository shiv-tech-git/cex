#!/bin/bash

set -e
cex_enable_debug

function print_help
{
    cat $1 | sed '/^##/d' | sed "s/<CEX_APP_NAME>/${CEX_APP_NAME}/" | tr -d '"#'
}

print_help ${CEX_ROOT}/commands
print_help ${CEX_APP_ROOT}/commands
