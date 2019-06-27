#!/bin/bash
## macOS local test suite

REPO_DIRECTORY=$(dirname "${BASH_SOURCE[0]}"| xargs dirname| xargs dirname)

rsync -avzP -e 'ssh -p 22' "$REPO_DIRECTORY/" 10.21.42.29:Projects/devenv-app/

ssh -p 22 macos-testbench PATH=/bin:/usr/bin/:/usr/local/bin /Users/jgrancell/Projects/devenv-app/tests/functionality.sh
