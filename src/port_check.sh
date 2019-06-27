#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function port_check() {
    PORT=$1
    CHECK_RESULTS=$(docker ps -q --filter publish="$PORT")

    if [[ "$CHECK_RESULTS" == "" ]]; then
        false
    else
        true
    fi
}
