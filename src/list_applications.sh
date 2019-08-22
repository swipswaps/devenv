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
    while IFS= read -r -d '' FILE; do
        if grep -q "Start Application" "$FILE"; then
            APP=$(grep "Start Application" < "$FILE" | sed 's/  ## Start Application - //g')
            echo "    - $APP"
        fi
    done <  <(find "$ENABLED_PROJECTS_DIRECTORY" -type f -print0 | sort -z)
}
