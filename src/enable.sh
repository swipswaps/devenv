#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function enable() {
    ENABLED_PATH="$BASE_DIRECTORY/environment/enabled"
    TARGET_PATH="$BASE_DIRECTORY/templates/compose_parts/$TARGET"

    if [[ -d "$TARGET_PATH" ]]; then
        if [[ -f "$TARGET_PATH/$ENABLE_VERSION.yml" ]]; then
            cp "$TARGET_PATH/$ENABLE_VERSION.yml" "$ENABLED_PATH/"
        else
            echo "The specified version for $TARGET ($ENABLE_VERSION) is not supported."
            echo "Supported versions are:"
            for FILE in $(ls "$TARGET_PATH" | grep yml | $SED_BINARY 's/.yml//g'); do
                echo "  - $FILE"
            done
            exit 1
        fi
    else
        echo "$TARGET is not a supported service. Supported services are:"
        echo "  - mariadb"
        echo "  - postgres"
        echo "  - phpmyadmin"
        exit 1
    fi
}
