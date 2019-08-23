#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function diagnostics() {

    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
    fi

    echo "Devenv Diagnostic Testing"
    echo ""
    echo "Please paste all of this output in an issue if requested."
    echo "Devenv Diagnostic Information"
    echo ""
    echo "Operating System: $PRETTY_NAME"
    echo "OS Version: $OSTYPE"
    echo "Core application version: $VERSION"
    echo "Docker version: $(docker -v)"
    echo "Shell Version: $SHELL"
    echo ""
    echo "Devenv version: $VERSION"
    echo ""
    echo "Beginning troubleshooting process:"
    echo ""

    ## Sed Testing
    echo "Identified SED binary: $SED_BINARY"
    echo "Running SED test"
    echo "testing" > /tmp/sed-test.txt
    $SED_BINARY -i 's/testing/successful-sed-test/g' /tmp/sed-test.txt
    SED_CONTENTS=$(cat /tmp/sed-test.txt)
    if [[ "$SED_CONTENTS" == "successful-sed-test" ]]; then
        echo "SED test completed successfully"
        EXIT_STATUS=0
    else
        echo "SED test failed - Actual file content: $SED_CONTENTS"
        EXIT_STATUS=1
    fi
    rm /tmp/sed-test.txt

    echo ""
    echo "Diagnostics completed."
    exit $EXIT_STATUS
}
