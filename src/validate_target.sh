#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function validate_target() {
    if [[ "$COMMAND" == 'delete' ||
         "$COMMAND" == 'relocate' ||
         "$COMMAND" == 'connect' ]]; then
        if [[ "$TARGET" != "" ]]; then
            true
        else
            echo "The command \"$COMMAND\" requires an application as a target, in the format:"
            echo "    devenv $COMMAND my-app"
            echo ""
            list_applications
            exit 1
        fi
    fi
}
