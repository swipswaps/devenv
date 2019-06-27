#!/usr/bin/env bash

# Demo sample_script.sh tests

testDetectOS() {
    # Load script for testing
    source src/functions/detect_os.sh
    detect_os

    if [[ "$CI_PIPELINE" == "travis" ]]; then
        assertEquals $SED_BINARY "gsed"
    else
        assertEquals $SED_BINARY "sed"
    fi
}

. shunit2-2.1.7/shunit2
