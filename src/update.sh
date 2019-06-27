#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function update() {
    echo "Updating devenv images."

    for CATEGORY in "$IMAGES_DIRECTORY/"*; do
        CATEGORY_NAME=$(basename "$CATEGORY")
        for IMAGE in "$IMAGES_DIRECTORY/$CATEGORY_NAME"/*; do
            IMAGE_NAME=$(basename "$IMAGE")
            # shellcheck disable=SC1090
            source "$IMAGES_DIRECTORY/$CATEGORY_NAME/$IMAGE_NAME"

            if [[ "$DOCKER_REGISTRY" != '' ]]; then
                # shellcheck disable=SC2086 disable=SC2046
                echo "$GITLAB_TOKEN" | docker login -u $(id -un) --password-stdin $DOCKER_REGISTRY
            fi
            "$DOCKER_BINARY" pull "$DOCKER_REGISTRY$DOCKER_NAMESPACE$CATEGORY_NAME:$IMAGE_NAME"
        done
    done
}
