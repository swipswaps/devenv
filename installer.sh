#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Docker-based web development platform
#
# --------------------------------------------------

VERSION="v0.1.0-alpha"
REPO_URL="git@gitlab.com:devenv-app/devenv.git"

echo -e "\\033[34m"
echo "   ____           ______         "
echo "   |    \\ ___ _ _|   __|___ _ _ "
echo "   |  |  | -_| | |   __|   | | |"
echo "   |____/|___|\\_/|_____|_|_|\\_/ "
echo -e "\\033[0m"
echo "Web Application Development Environment"
echo "Installer Version: $VERSION"
echo ""
echo "=================================="
echo ""
echo "DevEnv uses Docker to provide custom development environments. Make sure that"
echo "you have Docker installed before you attempt to run DevEnv."
echo ""

if ! command -v git > /dev/null; then
    echo -e "\\033[31mGit is required for installation to proceed.\\033[0m"
    exit 1
fi

UNATTENDED="n"
DEVELOPMENT="n"
LOCAL="n"
for ARGUMENT in "$@"; do
    case $ARGUMENT in
        "--unattended")
            UNATTENDED="y"
            ;;
        "--development")
            DEVELOPMENT="y"
            ;;
        "--local")
            LOCAL="y"
            ;;
    esac
done

if [[ "$UNATTENDED" == "y" ]]; then
    echo -e "\\033[33mUnattended installation mode enabled.\\033[0m"
    PROCEED="y"
else
    echo "Proceed with installation? [y/N] "
    read -r PROCEED
fi

if [[ $PROCEED == "y" || "$PROCEED" == "yes" ]]; then
    echo ""
    echo "Beginning the installation process."
    echo ""

    if [[ $OSTYPE == "darwin"* ]]; then
      USER_ACCOUNT=$(id -un)
      BASE_DIRECTORY="/Users/$USER_ACCOUNT/.devenv"
      MISSING_DEPS="n"

      if ! command -v greadlink > /dev/null; then
          echo -e "\\033[31mYou are missing the coreutils dependency.\\033[0m"
          MISSING_DEPS="y"
      fi

      if ! command -v gsed > /dev/null; then
          echo -e "\\033[31mYou are missing the gnused dependency.\\033[0m"
          MISSING_DEPS="y"
      fi

      if ! command -v git > /dev/null; then
          echo -e "\\033[31mYou are missing the git dependency.\\033[0m"
          MISSING_DEPS="y"
      fi

      if [[ "$MISSING_DEPS" == "y" ]]; then
          echo ""
          echo "OSX installations require two dependencies installed by brew:"
          echo "  - gnused"
          echo "  - coreutils"
          echo ""
          echo "Additionally, Devenv requires git to be installed. This can be done however you see fit."
          echo ""
          echo "Please ensure that you have installed all three of these dependencies, and then try again."
          exit 1
      fi
    else
      BASE_DIRECTORY="$HOME/.devenv"
    fi

    if [[ "$LOCAL" == "n" ]]; then
        git clone "$REPO_URL" "$BASE_DIRECTORY" --quiet
    else
        rsync -azP ./ "$BASE_DIRECTORY/"
    fi


    if [[ -d "/usr/local/bin" ]]; then
        BIN_INSTALL_PATH="/usr/local/bin"
    elif [[ -d "/usr/bin" ]]; then
        BIN_INSTALL_PATH="/usr/bin"
    else
        BIN_INSTALL_PATH="/bin"
    fi

    cd "$BASE_DIRECTORY" || exit 1
    LATEST_TAG=$(git tag --list | tail -n 1)

    if [[ "$LOCAL" == "n" ]]; then
        if [[ "$DEVELOPMENT" == "y" ]]; then
            git checkout v2.0.0-dev --quiet
        else
            git checkout "$LATEST_TAG" --quiet
        fi
    fi

    ## Verifying that the git clone completed properly
    if [[ -f "$BASE_DIRECTORY/bin/devenv" ]]; then

        if [[ -w $BIN_INSTALL_PATH ]]; then
            rm -f "$BIN_INSTALL_PATH/devenv"
            ln -s "$BASE_DIRECTORY/bin/devenv" "$BIN_INSTALL_PATH/devenv"
        else

            if [[ "$UNATTENDED" == 'n' ]]; then
                echo "The binary path $BIN_INSTALL_PATH is not writable."
                echo "Local path: $BASE_DIRECTORY/bin/devenv"
                echo -n "Would you like to add the local Devenv path to your system path? [y/N] "
                read -r BIN_PROCEED
                echo ""
            else
                BIN_PROCEED="y"
            fi

            if [[ "$BIN_PROCEED" == 'y' || "$BIN_PROCEED" == 'yes' ]]; then
                BASHRC_TARGET='/dev/null'
                if [[ -f "$HOME/.bashrc-local" ]]; then
                    if ! grep -q "Helper scripts to enable the Devenv" "$HOME/.bashrc-local"; then
                        BASHRC_TARGET="$HOME/.bashrc-local"
                    fi
                else
                    if grep -vq "Helper scripts to enable the Devenv" "$HOME/.bashrc"; then
                        BASHRC_TARGET="$HOME/.bashrc"
                    fi
                fi
                {
                    echo ""
                    echo "# Helper scripts to enable the Devenv development environment application"
                    echo "PATH=\"$BASE_DIRECTORY/bin:\$PATH\""
                } >> "$BASHRC_TARGET"
            else
                echo "You will need to manually symlink $BASE_DIRECTORY/bin/devenv into your"
                echo "configured path, or add $BASE_DIRECTORY/bin to your shell's PATH. Continuing."
                echo ""
            fi
        fi

        echo ""
        echo -e "\\033[32mInstallation is complete. You can create new applications by running:"
        echo "    devenv launch /path/to/codebase"
        echo ""
        echo "You can update Devenv at any time by running:"
        echo -e "    devenv updateself\\033[37m"
        echo ""
        echo "If you have any questions please contact Josh via Slack."
    else
        echo "Devenv was not able to clone down from Gitlab properly. Exiting."
        exit 1
    fi
else
    echo ""
    echo "You have cancelled the install process."
    exit 0
fi
