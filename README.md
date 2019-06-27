# Devenv

Docker-based web application development application, written in Bash.

#### Table of Contents

1. [Description](#description)
2. [Installing Devenv](#installing-devenv)
3. [Setting Up Devenv Applications](#setting-up-devenv-applications)
4. [Usage](#usage)
  1. [Detailed Information and Architecture](#detailed-information-and-architecture)
  2. [Database Access](#database-access)
  3. [Updating](#updating)
5. [Supported Languages](#supported-languages)

## Current Build Status

[![Release Version](https://img.shields.io/badge/development-v0.1.0--alpha-orange.svg)](https://gitlab.com/devenv-app/devenv/tags/)


|   OS     |                                                                    Status                                                                    |
| -------- | :------------------------------------------------------------------------------------------------------------------------------------------- |
| Linux    | [![pipeline](https://gitlab.com/devenv-app/devenv/badges/rewrite/pipeline.svg)](https://gitlab.com/devenv-app/devenv/pipelines)              |
| macOS    | [![OSX Build](https://travis-ci.com/jgrancell/devenv.svg?token=ySgyubABW6Cjgh9ahdn9&branch=rewrite)](https://travis-ci.com/jgrancell/devenv) |
| Windows* | [![pipeline](https://gitlab.com/devenv-app/devenv/badges/rewrite/pipeline.svg)](https://gitlab.com/devenv-app/devenv/pipelines)              |

\* Windows builds are only functional on Windows 10 using the Ubuntu or Fedora Linux subsystems.

## Description

Devenv is a web application development environment, written in Bash and using Docker.
Devenv provides lightweight environments to run your applications on during development,
without the need for setting up full webserver and language stacks.

Devenv simplifies your development pipeline by allowing you to develop your web
applications locally on your own machine using your choice of languages (PHP, Ruby),
language version (PHP 7.1 to 7.3, Ruby 2.3 to 2.6), and build-in package management
tools (composer, bundler).

All Devenv images are updated weekly with OS, package, and language updates.

All Devenv projects include a valid, browser-trusted SSL certificate that covers all
projects under `*.appenv.dev`. Devenv can be configured to use other root domains,
however we do not support this.

We provide a number of different language-specific images, to allow for compatibility testing with potential future language version updates.
Please see the [Supported Languages](#supported-languages) section below for more information about the different languages and language versions we currently package
with Devenv.

## Installing Devenv

Devenv is currently available for Linux and macOS. You can install Devenv by following the correct guide below:

| Operating System |                                            Installation Guide                                             |
| :--------------: | --------------------------------------------------------------------------------------------------------- |
| Linux            | [docs/INSTALLATION_LINUX.md](https://gitlab.com/devenv-app/devenv/blob/master/docs/INSTALLATION_LINUX.md) |
| macOS            | [docs/INSTALLATION_macOX.md](https://gitlab.com/devenv-app/devenv/blob/master/docs/INSTALLATION_MACOX.md) |

If you have questions about the installation process or run into issues contact DevOps.

## Adding and removing Devenv Applications

#### Adding An Application

The Devenv environment runs multiple applications, each in their own container.
Devenv is really just a pretty facade for manipulating the `docker-compose.yml`
file found at `$HOME/.devenv/environment/docker-compose.yml`, so you can always
manually update that file to tweak applications.

To add a new application, you can run two different commands: `devenv new` or `devenv launch`.

`devenv new` is a guided installer, which lets you choose the exact:
* Project name
* Project path
* Document root
* PHP version

`devenv launch` is an automated installer, which uses sane defaults and can be
manipulated by custom devenv helper files. These helper files are:

|     Helper File   | Description                                         |
| :---------------: | :-------------------------------------------------: |
|   `.devenv-lang`  | Sets the language. Valid values: `php`, `ruby`      |
|   `.devenv-ver`   | Sets the language version. Valid values are `Major.Minor` semantic version values, such as `7.1`, `2.4`, etc.  |
| `.devenv-docroot` | Sets the project docroot. Always include the beginning `/`. |

If you do not include helper files, `devenv launch` will look at your codebase and
make educated guesses. It will default to PHP unless otherwise specified, and will
default to the current middling PHP. So for example, if PHP 7.1, 7.2, and 7.3 are
all stable releases it will default to PHP 7.2.

|   Application | Document Root Path |
| :-----------: | :----------------: |
| Generic PHP   | `/`                |
| Laravel       | `/public`          |

I stronly recommend using `devenv launch` because it's much simpler, unless the project
you are working on is a special snowflake with a custom document root.

#### A Note On The Application Codebase

Devenv, as previously mentioned, is just a fancy wrapper for Docker Compose.
Devenv mounts your codebase into an Apache webserver container. While this
mounting is not read only, the only things that can affect your codebase are
the commands that you run.

Note, however, that when using a web-based GUI for your application uploading
files **can** cause files to be temporarily placed into a temporary upload
directory on the container. This varies wildly between applications, with some
using their own in-codebase temp path and other using the system temp path.
Any files that are saved to the system temp path **will** be deleted when the container is restarted, just like they would eventually be garbage collected by a normal webserver.

#### Removing An Application

Removing application is easy, just run `devenv delete myapp`. This will not delete:
* The codebase
* Any configured databases

Deleting an application will only remove its container definition from the Devenv
docker-compose.yml file.

## Usage

Once you are ready to launch the development environment, you can do so by running
`devenv start`. You can stop the environment with `devenv stop`.

To see a full list of available devenv commands, use `devenv help`.

#### Database Access

Once you have run `devenv start`, all of your projects are running. This includes
all of the helper services:

* The nginx load balancer
* The MariaDB database container
* The Postgresql database container

To access either the MariaDB or Postgresql containers, you can use your standard
command-line clients or applications of choice. By default, the admin credentials
for these services are:

* Username: root
* Password: devenv

For example, to connect to MariaDB you can use:

```bash
mysql -u root -p -h 127.0.0.1
```

#### Container Access and Dependency Management

Most of our projects require some sort of dependency management, be it PHP
Composer or Ruby Bundler. Devenv supports the following dependency managers natively:

* Composer: `devenv composer blah blah blah`

For other dependency managers, if you need to run them within the container instead
of just within the codebase (you probably don't), you can connect to a project's
container by running `devenv connect projectname`.

Using `devenv connect projectname` will put you directly into the project root within
the container. The main caveat to this is that you will be using root, so you may
run into permission issues.

#### Updating

Images are updated automagically every Sunday evening as part of our Gitlab CI
pipeline. The pipeline applies a basic `yum update` or `apk update` to the image
to pull down the latest bugfix and security updates for the underlying OS.

Manual changes to packages or configuration are all documented in this repository's
IMAGE_CHANGELOG.md. We change images to:
* mirror changes made to production
* reduce the size of our images
* add new services/features, or remove older services

You can automatically update your images by running `devenv update`.

Devenv itself can be updated using `devenv updateself` or `devenv selfupdate`.

## Supported Languages

We currently support PHP and Ruby languages via custom Docker containers. All containers are versioned. Versions are **not** bumped for the weekly package updates. Versions are bumped when a configuration or other package change has been requested.

|  Language   |  Version |                       Image Revision                          |
| :---------: | :------: | :-----------------------------------------------------------: |
|   PHP       |   7.1    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |
|   PHP       |   7.2    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |
|   PHP       |   7.3    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |
|   Ruby      |   2.3    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |
|   Ruby      |   2.4    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |
|   Ruby      |   2.5    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |
|   Ruby      |   2.6    | ![v1.0.0](https://img.shields.io/badge/image-v1.0.0-blue.svg) |

\* These are alpha, beta, or release candidate language releases, so may not be up to date with the latest bleeding edge changes.

## Supported Operating Systems

We are actively supporting the following operating systems:
* Ubuntu 16.04 and 18.04
* Fedora 28+
* Arch Linux
* macOS 10.13
