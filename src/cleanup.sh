#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function cleanup() {
    stop
    docker ps -aqf name="devenv-*" | xargs docker container kill 2> /dev/null
    docker ps -aqf name="devenv-*" | xargs docker container rm 2> /dev/null
    rm -f "$BASE_DIRECTORY/.devenv-lock"
    echo -e "\\033[33mIf you wish to remove your database data you must do so manually with 'docker volume rm devenv-mariadb'.\\033[0m"
}
