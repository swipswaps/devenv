#!/bin/bash

## Verifying that the application directory exists
if [[ -d "$HOME/.devenv" ]]; then
    FAILURE="no"

    if command -v devenv > /dev/null; then
        echo "The Devenv binary has been successfully deployed."
    else
        echo -e "\\033[31mThe Devenv binary cannot be found in PATH.\\033[0m"
        FAILURE="yes"
    fi

    if [[ -d "$HOME/.devenv/.git" ]]; then
        echo "The git directory has been found successfully."
    else
        echo -e "\\033[31mThe Devenv .git repository cannot be found.\\033[0m"
        FAILURE="yes"
    fi

    if [[ "$FAILURE" == "no" ]]; then
        exit 0
    fi
    exit 1
else
    echo "The BASE_DIRECTORY $HOME/.devenv does not exist."
    exit 1
fi
