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
    ACTIVE_PATH="$BASE_DIRECTORY/environment/active"
    COMPOSE_FILE="$ACTIVE_PATH/docker-compose.yml"
    if [[ -f "$COMPOSE_FILE" ]]; then

        echo "Stopping Devenv."
        cd "$ACTIVE_PATH" || exit 1

        "$COMPOSE_BINARY" down
        rm -f "$COMPOSE_FILE"
    else
        echo "Devenv is not running. If some devenv components still exist, try 'devenv cleanup'."
    fi
}
