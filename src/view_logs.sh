#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function view_logs() {
    echo "Viewing the last 50 lines of logs from each container."
    cd "$ACTIVE_DIRECTORY" || exit 1
    "$COMPOSE_BINARY" logs --tail 50
}
