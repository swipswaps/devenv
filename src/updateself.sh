#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function updateself() {
    echo "Updating DevEnv application."

    PREVIOUS_VERSION=$(cat "$BASE_DIRECTORY/version.txt")
    cd "$BASE_DIRECTORY" || exit 1
    git fetch --quiet

    if [[ "$TARGET" == "--development" ]]; then
        git checkout v2.0.0-dev --quiet --force
        git pull --quiet
    else
        TARGET_VERSION=$(git tag --list | tail -n 1)

        if [[ $PREVIOUS_VERSION != "$TARGET_VERSION" ]]; then
            echo "Devenv $TARGET_VERSION is available. Would you like to update now? [y/N]"
            read -r PROCEED_UPDATE

            if [[ "$PROCEED_UPDATE" == "y" || "$PROCEED_UPDATE" == "Y" ]]; then
                git checkout "$NEW_VERSION" --quiet --force

                UPDATED_VERSION=$(cat "$BASE_DIRECTORY/version.txt")

                if [[ "$TARGET_VERSION" == "$UPDATED_VERSION" ]]; then
                    echo "DevEnv has been successfully updated to $TARGET_VERSION"
                else
                    echo -e "\\033[31mDevEnv failed to updated from $PREVIOUS_VERSION to $TARGET_VERSION. $UPDATED_VERSION identified.\\033[0m"
                fi
            fi
        fi
    fi
}
