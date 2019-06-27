#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function new_application() {
    ## Creating our first environment
    echo "Devenv runs using applications. Each application uses a different container."
    echo "What is the project name of the application you would like to create first?"
    read -r PROJECT_NAME

    echo ""

    echo "What is the full path to the codebase for this project?"
    # shellcheck disable=SC2034
    read -r PROJECT_PATH

    echo ""

    echo "If your application does not use its base directory as its document root"
    echo "please provide a relative document root (such as public or web) now: [default: none]"
    # shellcheck disable=SC2034
    read -r PROJECT_DOCROOT

    # shellcheck disable=SC2034
    COMPOSE_FILE="$ENV_DIRECTORY/docker-compose.yml"

    ## Updating the PROJECT_NAME variables
    USER=$(whoami)

    echo ""

    echo "Devenv will eventually support a number of different languages. For now"
    echo "we only support PHP. Select the language you would like to enable for"
    echo "your project: "
    echo "   1. PHP"
    echo "   2. Ruby"
    read -r LANGUAGE_SUPPORT

    ## Installing PHP-specific portions of the docker-compose.yml
    if [[ "$LANGUAGE_SUPPORT" == '1' ]]; then
        echo "What PHP version would you like to enable? You will be able to choose multiple times."
        echo "1. PHP 7.1 [our infrastructure default]"
        echo "2. PHP 7.2"
        echo "3. PHP 7.3"
        read -r ENABLE_PHP_VERSION
        echo ""

        if [[ $ENABLE_PHP_VERSION == "1" ]]; then
            # shellcheck disable=SC2034
            PHP_VERSION="7.1"
        fi

        if [[ $ENABLE_PHP_VERSION == "2" ]]; then
            # shellcheck disable=SC2034
            PHP_VERSION="7.2"
        fi

        if [[ $ENABLE_PHP_VERSION == "3" ]]; then
            # shellcheck disable=SC2034
            PHP_VERSION="7.3"
        fi

        # shellcheck disable=SC1090
        source "$TEMPLATES_DIRECTORY/compose_parts/applications/php.sh"
    elif [[ "$LANGUAGE_SUPPORT" == '2' ]]; then
      echo "What PHP version would you like to enable? You will be able to choose multiple times."
      echo "1. Ruby 2.3"
      echo "2. Ruby 2.4"
      echo "3. Ruby 2.5"
      read -r ENABLE_PHP_VERSION
      echo ""

      if [[ $ENABLE_PHP_VERSION == "1" ]]; then
          # shellcheck disable=SC2034
          RUBY_VERSION="2.3"
      fi

      if [[ $ENABLE_PHP_VERSION == "2" ]]; then
          # shellcheck disable=SC2034
          RUBY_VERSION="2.4"
      fi

      if [[ $ENABLE_PHP_VERSION == "3" ]]; then
          # shellcheck disable=SC2034
          RUBY_VERSION="2.5"
      fi

      # shellcheck disable=SC1090
      source "$TEMPLATES_DIRECTORY/compose_parts/applications/ruby.sh"
    fi

    echo "Devenv has been installed for your $PROJECT_NAME application. You can start the environment with 'devenv start $PROJECT_NAME'"
}
