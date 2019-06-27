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
    grep "Start Application" < "$ENV_DIRECTORY/docker-compose.yml" | while IFS= read -r LINE; do
        APP=$(echo "$LINE"| cut -d ' ' -f 7)
        echo "    - $APP"
    done
}
