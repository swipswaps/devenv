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
    if [[ ! -f "$COMPOSE_FILE" ]]; then

        echo "Starting Devenv."
        cd "$ACTIVE_DIRECTORY" || exit 1

        cat "$BASE_DIRECTORY/templates/compose_parts/header.yml" > "$COMPOSE_FILE"
        cat "$BASE_DIRECTORY/templates/compose_parts/ingress/nginx.yml" >> "$COMPOSE_FILE"

        PART_COUNT=$(find "$ENABLED_PROJECTS_DIRECTORY/" -type f -name "*.yml" | wc -l)

        if [ "$PART_COUNT" -gt 0 ]; then
            for PART in "$ENABLED_PROJECTS_DIRECTORY"/*.yml; do
                cat "$PART" >> "$COMPOSE_FILE"
            done
        fi

        "$COMPOSE_BINARY" up -d
    else
        echo "Devenv is already running. If it's not working, try 'devenv cleanup'"
    fi
}
