#!/bin/bash
# --------------------------------------------------
#
# Package: devenv
# Author: Josh Grancell <josh@joshgrancell.com>
# Description: Devenv command runner
# File Version: 1.0.0
#
# --------------------------------------------------
function launch() {

    if [[ ! -d "$TARGET" && -n "$TARGET" ]]; then
        echo "$TARGET is not a valid path to launch Devenv in."
        exit 1
    elif [[ ! -d "$TARGET" && -z "$TARGET" ]]; then
        TARGET="."
    fi

    PROJECT_PATH=$($READLINK_BINARY -f "$TARGET")
    PROJECT_NAME=$(basename "$PROJECT_PATH")

    echo "Provisioning the project $PROJECT_NAME with the codebase from $PROJECT_PATH."

    if [[ -f "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml" ]]; then
        echo -e '\\033[31mAn application already exists with that name.\\033[0m'
        exit 1
    fi

    if [[ "$PROJECT_NAME" == "" ]]; then
        echo "You must provide an application name."
        exit 1
    fi

    if [[ -f "$PROJECT_PATH/.devenv-lang" ]]; then
        echo "Devenv language boostrap file identified. Parsing."
        BOOTSTRAP=$(cat "$PROJECT_PATH/.devenv-lang")

        if [[ "$BOOTSTRAP" == 'php' ]]; then
            echo "PHP language bootstrapping enabled."
            LANGUAGE='php'
        elif [[ "$BOOTSTRAP" == 'ruby' ]]; then
            echo "Ruby language bootstrapping enabled."
            LANGUAGE='ruby'
        fi

        if [[ -f "$PROJECT_PATH/.devenv-ver" ]]; then
            SPEC_VERSION=$(cat "$PROJECT_PATH/.devenv-ver")
        elif [[ -f "$PROJECT_PATH/.ruby-version" && "$LANGUAGE" == 'ruby' ]]; then
            SPEC_VERSION=$(< "$PROJECT_PATH/.ruby-version" cut -d- -f2| cut -d\. -f1-2)
        else
            SPEC_VERSION="default"
        fi
    else
        echo "Unable to find a Devenv bootstrap file. Bootstrapping with PHP."
        LANGUAGE='php'
        SPEC_VERSION="default"
    fi

    if [[ -f "$PROJECT_PATH/.devenv-docroot" ]]; then
        echo "Devenv docroot bootstrapping file identified. Parsing."
        PROJECT_DOCROOT=$(cat "$PROJECT_PATH/.devenv-docroot")
    elif [[ -f "$PROJECT_PATH/yii" ]]; then
        PROJECT_DOCROOT="/web"
    elif [[ -f "$PROJECT_PATH/artisan" ]]; then
        PROJECT_DOCROOT="/public"
    elif [[ "$LANGUAGE" == "ruby" ]]; then
        PROJECT_DOCROOT="/public"
    else
        # shellcheck disable=SC2034
        PROJECT_DOCROOT=""
    fi

    # shellcheck disable=SC2034
    COMPOSE_FILE="$ENV_DIRECTORY/docker-compose.yml"
    USER=$(whoami)

    if [[ "$LANGUAGE" == 'php' ]]; then

        if [[ "$SPEC_VERSION" == "default" ]]; then
          PHP_VERSION="7.1"
        else
          # shellcheck disable=SC2034
          PHP_VERSION=$SPEC_VERSION
        fi

        # shellcheck disable=SC1090
        cp "$TEMPLATES_DIRECTORY/compose_parts/applications/php.yml" "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        sed -i.bak "s#SED_PROJECT_NAME#$PROJECT_NAME#g"       "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        sed -i.bak "s#SED_PHP_VERSION#$PHP_VERSION#g"         "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        sed -i.bak "s#SED_PROJECT_PATH#$PROJECT_PATH#g"       "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        sed -i.bak "s#SED_BASE_DIRECTORY#$BASE_DIRECTORY#g"   "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        sed -i.bak "s#SED_USER#$USER#g"                       "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        sed -i.bak "s#SED_PROJECT_DOCROOT#$PROJECT_DOCROOT#g" "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
        rm -f "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml.bak"
    elif [[ "$LANGUAGE" == 'ruby' ]]; then
        if [[ "$SPEC_VERSION" == "default" ]]; then
            RUBY_VERSION="2.3"
        else
            # shellcheck disable=SC2034
            RUBY_VERSION=$SPEC_VERSION
        fi

        # shellcheck disable=SC1090
        cp "$TEMPLATES_DIRECTORY/compose_parts/applications/ruby.yml" "$ENABLED_PROJECTS_DIRECTORY/$PROJECT_NAME.yml"
    fi
    echo "Devenv has been installed for your $PROJECT_NAME application. You can start the application with 'devenv start'"
}
