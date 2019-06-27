## macOS Installation Guide

Installing on macOS is pretty straightforward as long as you're familiar with
***brew*** and the OSX terminal.

### Step 1: Installing Dependencies

Unlike with Linux, macOS requires a substantial amount of *navigating to websites and
downloading installers*. It will take about a half hour to install all of the required
dependencies for Devenv to work on macOS, with the bulk of the time on installing XCode.

##### Step 1a: XCode
You can install XCode through the [standalone installer](https://developer.apple.com/downloads) or via the Mac App Store, and it doesn't particularly matter which. This
guide was written having used the Mac App Store installation, so you should probably
go that route unless you have a compelling reason otherwise.

Once you have installed XCode, open up a terminal and run the command `git -v`.
If you get back a response that looks like this, it didn't install properly:

```bash
macos:~ root > git --version
xcode-select: error: no developer tools were found at '/Applications/Xcode.app', and no install could be requested (perhaps no UI is present), please install manually from 'developer.apple.com'.
```

If you get a nag screen to accept a license when you run `git --version` or you just
get the version of git installed, then you're good to move on.

Next, you need to install Homebrew.

##### Step 1b: Homebrew

Homebrew is installed by cloning down a git repository. Follow the steps in this
guide at [brew.sh](https://brew.sh/).

##### Step 1c: Devenv Dependencies

Using Homebrew, install the following:

* coreutils
* gnu-sed

This is done in the terminal. It should look similar to this:

```bash
brew install coreutils gnu-sed
```

Once this is done you can verify both installed properly by running the commands
`command -v gsed` and `command -v greadlink` and ensuring that a path is returned
for both.

```bash
macos:~ jgrancell$ command -v gsed
/usr/local/bin/gsed
macos:~ jgrancell$ command -v greadlink
/usr/local/bin/greadlink
```

### Step 2: Installing Docker

Docker is the cornerstone of Devenv. If your hardware or macOS version doesn't
support Docker, you cannot use Devenv.

To install Docker, follow
[this official Docker installation guide](https://docs.docker.com/docker-for-mac/install/).
You will have to register for an account on the Docker Store.

Once Docker is installed on your system, test it by running `docker info` to
verify that you can run Docker as your local user. If you can't, re-read the
installation guide provided by Docker.

Docker Compose is a container orchestration tool that lets us group containers
into the Devenv environment to work in concert with each other.

The macOS Docker installer includes Docker Compose as part of the core Docker
application, so you don't need to do anything special to install Docker Compose.

You are going to need to log into Docker Hub via the command line for Devenv to work
properly. You *may* get an error that looks like `exited with "User interaction is not allowed"`. You can correct this in one of two ways in one of two ways:

1. Run the command `security unlock-keychain` and then try `docker login` again.
2. Alternatively, you can open up Preferences on the Docker GUI and disable `Securely
store Docker logins in macOS keychain`, but this isn't recommended.

### Step 4: Installing Devenv

Now that you're done with all of the prerequisite installs, installing Devenv itself
is **very** simple.

It is almost always a very bad idea to simply curl a bash script into a pipe and
run it from the internet, but you **can** do that if you'd like. You should **always**
read through scripts you download from the internet, and this intaller is no exception.

To install Devenv, follow these steps:

1. Clone down the Devenv repository from `git@gitlab.com:devenv-app/devenv.git`
2. Navigate into the repository directory via `cd devenv`
3. Read through the installer, and make sure you're comfortable with running the script.
3. Run `/bin/bash installer.sh`
4. Follow the prompts from the installer.

Devenv is now installed. Check out the main repository README.md for tips on how to use
Devenv.

***NOTE***: The first time you run a Devenv command, you **will** get output indicating
that your user is not in the Docker group. This is entirely expected on macOS,
and this warning will not appear a second time. If it does continue to appear,
contact DevOps because Apple changed something with how Docker installs.
