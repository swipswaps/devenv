#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function stop() {
    if [[ -f "$COMPOSE_FILE" ]]; then

        echo "Stopping Devenv."
        cd "$ACTIVE_DIRECTORY" || exit 1

        "$COMPOSE_BINARY" down
        rm -f "$COMPOSE_FILE"
    else
        echo "Devenv is not running. If some devenv components still exist, try 'devenv cleanup'."
    fi
}
