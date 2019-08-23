#!/bin/bash
# This mimics the functionality stage of our CI pipeline

echo "Beginning the Funcationlity test process."
echo ""

TESTDIR="/tmp/devenv-results"
rm -rf $TESTDIR
mkdir "$TESTDIR"

echo "Test #1 - 'devenv status' with no containers"

devenv status > "$TESTDIR/status"

if [[ $(cat "$TESTDIR/status") == "" ]]; then
    echo "Test #1 - Success"
    echo ""
else
    echo "Test #1 - Failure"
    exit 1
fi

## Testing `devenv help`
echo "Test #2 - 'devenv help'"

devenv help > "$TESTDIR/help"

cat > "$TESTDIR/help_correct" <<- EOM
All commands must be in the form of:
    devenv [command] [environment]

Standard Commands:
    help               Shows this message.
    start              Starts all Devenv projects.
    stop               Stops all Devenv projects.
    restart            Restarts all Devenv projects.
    update             Updates all Devenv containers and restarts projects.
    status             Shows the current status of all Devenv projects and services.
    list               Lists all enabled Devenv projects.

Project Commands:

    launch [target]    Launches a new Devenv project at the [target] location automatically.
    new                Interactive wizard to launch a new Devenv project with custom settings.
    delete [target]    Removes a Devenv project (does not affect the codebase).
    connect [target]   Connects to a running Devenv project's CentOS container.

Project Helpers:
    relocate [target]  Moves your command line client into the Devenv project codebase path.
    composer [command] Runs a composer command against the current codebase.

Advanced Tools:
    diagnostics        Provides diagnostic output for DevOps troubleshooting.
    updateself         Updates the Devenv application itself.
EOM

if diff "$TESTDIR/help" "$TESTDIR/help_correct"; then
    echo "Test #2 - Success"
    echo ""
else
    echo "Test #2 - Failure"
    exit 1
fi

## Testing `devenv launch`
if [[ -d /private/tmp ]]; then
    ## This is a macOS machine we're testing on and it's a special snowflake
    CODE_BASE="/private/tmp/devenv-tests/code_base_vanilla"
    mkdir -p "$CODE_BASE"
    echo "Test #3 - 'devenv launch' without pre-seeding"

    devenv launch "$CODE_BASE" > "$TESTDIR/launch-vanilla"

    cat > "$TESTDIR/launch-vanilla-correct" <<- EOM
Provisioning the project code_base_vanilla with the codebase from /private/tmp/devenv-tests/code_base_vanilla.
Unable to find a Devenv bootstrap file. Bootstrapping with PHP.
Devenv has been installed for your code_base_vanilla application. You can start the application with 'devenv start'
EOM

    if [[ -d "$HOME/.devenv/environment" ]]; then
        if [[ -f "$HOME/.devenv/environment/enabled/code_base_vanilla.yml" ]]; then
            if diff "$TESTDIR/launch-vanilla" "$TESTDIR/launch-vanilla-correct"; then
                echo "Test #3 - Success"
                echo ""
            else
                echo "Test #3 - Failure (typo)"
                exit 1
            fi
        else
          echo "Test #3 - Failure (compose-file-failure)"
          exit 1
        fi

    else
        echo "Test #3 - Failure (setup)"
        exit 1
    fi

    rm -rf "$CODE_BASE"
else
    CODE_BASE="/tmp/devenv-tests/code_base_vanilla"
    mkdir -p "$CODE_BASE"
    echo "Test #3 - 'devenv launch' without pre-seeding"

    devenv launch "$CODE_BASE" > "$TESTDIR/launch-vanilla"

    cat > "$TESTDIR/launch-vanilla-correct" <<- EOM
Provisioning the project code_base_vanilla with the codebase from /tmp/devenv-tests/code_base_vanilla.
Unable to find a Devenv bootstrap file. Bootstrapping with PHP.
Devenv has been installed for your code_base_vanilla application. You can start the application with 'devenv start'
EOM

    if [[ -d "$HOME/.devenv/environment" ]]; then
        if [[ -f "$HOME/.devenv/environment/enabled/code_base_vanilla.yml" ]]; then
            if diff "$TESTDIR/launch-vanilla" "$TESTDIR/launch-vanilla-correct"; then
                echo "Test #3 - Success"
                echo ""
            else
                echo "Test #3 - Failure (typo)"
                exit 1
            fi
        else
          echo "Test #3 - Failure (compose-file-failure)"
          exit 1
        fi

    else
        echo "Test #3 - Failure (setup)"
        exit 1
    fi

    rm -rf "$CODE_BASE"
fi


## Testing `devenv start`
echo "Test #4 - 'devenv start'"
devenv start > "$TESTDIR/start-vanilla"

if [[ $(cat "$TESTDIR/start-vanilla") == "Starting Devenv." ]]; then
    echo "Test #4 - Success"
else
    cat "$TESTDIR/start-vanilla"
    echo "Test #4 - Failure"
    exit 1
fi

## Testing `devenv status`
echo "Test #5 - 'devenv status' with containers"
devenv status > "$TESTDIR/status-vanilla"


if grep "devenv-code_base_vanilla:" "$TESTDIR/status-vanilla" | grep -q "running"; then
   echo "Test #5 - Success"
   echo ""
else
    echo "Test #5 - Failure"
    exit 1
fi

## Testing `devenv stop`
echo "Test #6 - 'devenv stop'"
devenv stop > "$TESTDIR/stop-vanilla"

if [[ $(cat "$TESTDIR/stop-vanilla") == "Stopping Devenv." ]]; then
    echo "Test #6 - Success"
    echo ""
else
    echo "Test #6 - Failure"
    exit 1
fi

# Testing `devenv status` post-deletion
echo "Test #7 - 'devenv status' without containers"
devenv status > "$TESTDIR/status"

if [[ $(cat "$TESTDIR/status") == "" ]]; then
    echo "Test #1 - Success"
    echo ""
else
    echo "Test #1 - Failure"
    exit 1
fi
## Testing `devenv delete`
echo "Test #8 - 'devenv delete'"
devenv delete code_base_vanilla > "$TESTDIR/delete-vanilla"

if [[ ! -f "$HOME/.devenv/environments/enabled/code_base_vanilla.yml" ]]; then
    echo "Test #8 - Success"
    echo ""
else
    echo "Test #8 - Failure"
fi

rm -rf $TESTDIR

echo "Devenv functionality tests completed successfully."
