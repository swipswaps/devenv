#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function status() {
    docker ps --filter name="devenv*" --format '{{.Names}}\t{{.Status}}' | awk '{print $1 " " $2}' > /tmp/docker-status.tmp
    while read -r container status; do
        if [[ $status == 'Restarting' ]]; then
            echo -e "$container: \\033[33mfailed - restart loop\\033[0m"
        elif [[ $status == 'Up' ]]; then
            echo -e "$container: \\033[32mrunning\\033[0m"
        else
            echo -e "$container: \\033[31mstopped\\033[0m"
        fi
    done < "/tmp/docker-status.tmp"
    rm /tmp/docker-status.tmp
}
