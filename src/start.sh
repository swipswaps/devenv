#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function start() {
    ACTIVE_PATH="$BASE_DIRECTORY/environment/active"
    ENABLED_PATH="$BASE_DIRECTORY/environment/enabled"
    COMPOSE_FILE="$ACTIVE_PATH/docker-compose.yml"
    if [[ ! -f "$COMPOSE_FILE" ]]; then

        echo "Starting Devenv."
        cd "$ACTIVE_PATH" || exit 1

        cat "$BASE_DIRECTORY/templates/compose_parts/header.yml" > "$COMPOSE_FILE"
        cat "$BASE_DIRECTORY/templates/compose_parts/ingress/nginx.yml" >> "$COMPOSE_FILE"

        PART_COUNT=$(find "$ENABLED_PATH/" -type f -name "*.yml" | wc -l)

        if [ "$PART_COUNT" -gt 0 ]; then
            for PART in "$ENABLED_PATH"/*.yml; do
                cat "$PART" >> "$COMPOSE_FILE"
            done
        fi

        "$COMPOSE_BINARY" up -d
    else
        echo "Devenv is already running. If it's not working, try 'devenv cleanup'"
    fi
}
