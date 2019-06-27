#!/bin/bash
# Builds all of Devenv into a single application file
CURRENT_DIR=$(pwd)

if [ -d "$CURRENT_DIR/src" ] && [ -d "$CURRENT_DIR/build" ] && [ -d "$CURRENT_DIR/bin" ]; then
    echo "Beginning build process."
    BUILD_FILE="$CURRENT_DIR/build/devenv.build"
    APPLICATION_FILE="$CURRENT_DIR/bin/devenv"

    if [ -f "$BUILD_FILE" ]; then
        echo "A compiled Devenv application file already exists."
        echo -n "Would you like to overwrite it? [y/N] "
        read -r CONTINUE
    else
        CONTINUE="y"
    fi

    if [ "$CONTINUE" = "y" ]; then
        VERSION=$(grep -m 1 "VERSION" "$CURRENT_DIR/src/devenv" | cut -d\" -f2)
        {
            echo "#!/bin/bash"
            echo "# --------------------------------------------------"
            echo "#"
            echo "# Package: Devenv"
            echo "# Author: Josh Grancell <josh@joshgrancell.com>"
            echo "# Description: Docker-based web development platform"
            echo "# Version: $VERSION"
            echo "#"
            echo "# --------------------------------------------------"
            echo ""
        } > "$APPLICATION_FILE"

        COUNT=0

        for SCRIPT in "$CURRENT_DIR"/src/*.sh; do
            echo "Identified child script $SCRIPT"
            cat "$SCRIPT" >> "$BUILD_FILE"
            echo "" >> "$BUILD_FILE"
            COUNT=$((COUNT+1))
        done

        cat "$CURRENT_DIR/src/devenv" >> "$BUILD_FILE"

        # Cleaning up comments
        sed -i '/^#/d' "$BUILD_FILE"

        echo "Compiled $COUNT scripts into $BUILD_FILE."

        cat "$BUILD_FILE" >> "$APPLICATION_FILE"

        chmod +x "$APPLICATION_FILE"

        sha256sum "$APPLICATION_FILE" > "$APPLICATION_FILE.sha256"
        rm -f "$BUILD_FILE"
    else
        echo "Exiting."
        exit 1
    fi
else
    echo "Run this from within the root of the Repository."
fi
