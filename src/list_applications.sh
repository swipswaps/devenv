#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function list_applications() {
    echo "The following are all currently configured devenv applications:"
    for FILE in "$ACTIVE_DIRECTORY"/*; do
        APP=$(cut -d. -f1 <<< "$FILE")
        echo "    - $APP"
    done
}
