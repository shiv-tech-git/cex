#!/bin/bash

set -e
cex_enable_debug

if [ -d ${CEX_APP_ROOT}/.git ]; then
    cex_git_pull $CEX_APP_ROOT

    if [ -f ${CEX_APP_ROOT}/.gitmodules ]; then
        cex_git_submodule_update $CEX_APP_ROOT
    fi
else
    cex_git_pull $CEX_ROOT
fi
