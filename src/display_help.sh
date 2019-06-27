#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function display_help() {
    echo "All commands must be in the form of:"
    echo "    devenv [command] [environment]"
    echo ""
    echo "Standard Commands:"
    echo "    help               Shows this message."
    echo "    start              Starts all Devenv projects."
    echo "    stop               Stops all Devenv projects."
    echo "    restart            Restarts all Devenv projects."
    echo "    update             Updates all Devenv containers and restarts projects."
    echo "    status             Shows the current status of all Devenv projects and services."
    echo "    list               Lists all enabled Devenv projects."
    echo ""
    echo "Project Commands:"
    echo ""
    echo "    launch [target]    Launches a new Devenv project at the [target] location automatically."
    echo "    new                Interactive wizard to launch a new Devenv project with custom settings."
    echo "    delete [target]    Removes a Devenv project (does not affect the codebase)."
    echo "    connect [target]   Connects to a running Devenv project's CentOS container."
    echo ""
    echo "Project Helpers:"
    echo "    relocate [target]  Moves your command line client into the Devenv project codebase path."
    echo "    composer [command] Runs a composer command against the current codebase."
    echo ""
    echo "Advanced Tools:"
    echo "    diagnostics        Provides diagnostic output for DevOps troubleshooting."
    echo "    updateself         Updates the Devenv application itself."
}
