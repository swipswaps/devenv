#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function composer() {
    if command -v php > /dev/null; then
        php ../thirdparty/php/composer "$@"
    else
        echo "PHP is not installed on your machine, therefore composer cannot be run."
    fi
}
