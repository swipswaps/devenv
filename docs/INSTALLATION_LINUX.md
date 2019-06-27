## Linux Installation Guide

Installing on Linux is very straightforward, and this guide will not hold your
hand as much as the macOS guide does.

### Step 0: Supported Distributions

Devenv officially supports and is tested against a number of different distributions. These include:

* Arch Linux
* Ubuntu
* Fedora
* Alpine Linux

There are only four core requirements:
* Bash
* GNU coreutils
* Docker
* Docker Compose

If your distribution meets all three of the above requirements, it ***should***
work fine. If you're planning on using Devenv heavily on a non-officially supported
distribution, drop me a [Feature Request](https://github.com/jgrancell/devenv/issues)
and I'll work on officially supporting it.

### Step 1: Installing Docker

Docker is the cornerstone of Devenv. If your hardware or distribution doesn't
support Docker, you cannot use Devenv.

To install Docker, follow the correct guide. **DO NOT** use your package manager's
version unless you're running Arch or you're running another rolling release that
keeps the actual repo version up to date.

* Ubuntu: [Follow this guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/).
* Debian: [Follow this guide](https://docs.docker.com/install/linux/docker-ce/debian/).
* Fedora: [Follow this guide](https://docs.docker.com/install/linux/docker-ce/fedora/).
* Arch Linux: Install from the Arch repository, it typically matches Docker's own repositories.

Ensure that you add your user to the Docker group, as the guide says. Make sure you start
Docker and (most likely) enable it.

Once Docker is installed on your system, test it by running `docker info` to
verify that you can run Docker as your local user. If you can't, re-read the
installation guide provided by Docker.

### Step 2: Installing Docker Compose

Docker Compose is a container orchestration tool that lets Devenv group containers
into the Devenv environment to work in concert with each other

If you're on Arch Linux or another decently up-to-date distro, you can just install
the docker-compose package from your repositories. Otherwise, follow the general steps
below.

First, get the most recent version number of Docker Compose. To do this, go to
[the Github page](https://github.com/docker/compose/releases) and look at the latest
release.

Then, run the following command, replacing the X.X.X version number with the
number found on Github:

```bash
sudo curl -L https://github.com/docker/compose/releases/download/X.X.X/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
```

You'll need to set the docker-compose binary to executable.

### Step 3: Installing Devenv

Installing Devenv is as simple as running the installer.

It is almost always a very bad idea to simply curl a bash script into a pipe and
run it from the internet, but you **can** do that if you'd like. You should **always**
read through scripts you download from the internet, and this intaller is no exception.

1. Clone down the Devenv repository from `git@gitlab.com:devenv-app/devenv.git`
2. Navigate into the repository directory via `cd devenv`
3. Read through the installer, and make sure you're comfortable with running the script.
3. Run `/bin/bash installer.sh`
4. Follow the prompts from the installer.

Devenv is now installed. Reference the main repository README.md for more information
about the application.
