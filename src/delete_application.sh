#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function delete_application() {
    ENABLED_PATH="$BASE_DIRECTORY/environment/enabled"
    if [ -f "$ENABLED_PATH/$TARGET" ]; then
        rm "$ENABLED_PATH/$TARGET"
    else
        echo "The application $TARGET is not enabled in Devenv."
    fi
}
