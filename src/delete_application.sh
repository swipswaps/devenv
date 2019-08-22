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
    ENABLED_PROJECTS_DIRECTORY="$BASE_DIRECTORY/environment/enabled"
    if [ -f "$ENABLED_PROJECTS_DIRECTORY/$TARGET.yml" ]; then
        rm "$ENABLED_PROJECTS_DIRECTORY/$TARGET.yml"
        echo "Application $TARGET deleted from Devenv."
    else
        echo "The application $TARGET is not enabled in Devenv."
    fi
}
