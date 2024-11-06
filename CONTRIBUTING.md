# Contributing to samp-docker

All information related to contributing to the project can be found in this file. It is **mandatory** to read it before contributing to the project in order to follow the conventions and make the development process easier for everyone. Thank you for your understanding!

- [Contributing to samp-docker](#contributing-to-samp-docker)
  - [Getting the Project](#getting-the-project)
  - [Installation \& Launch](#installation--launch)
    - [Build the image locally](#build-the-image-locally)
    - [Usage](#usage)
  - [Project Conventions](#project-conventions)
    - [Versioning](#versioning)
    - [Git](#git)
    - [Code](#code)
      - [Indentation](#indentation)
      - [Code Quality](#code-quality)
    - [Structure](#structure)
  - [Submitting a Pull Request](#submitting-a-pull-request)
  - [Submitting an Issue](#submitting-an-issue)

## Getting the Project

The project is hosted in an online repository. It is recommended to associate your SSH keys with your account to clone the project via SSH for security reasons, but it is also possible to clone it via HTTPS.

Navigate to the folder where you want to clone the project (after creating it):  
On Windows:

```bat
cd %userprofile%\Documents\Projects\
```

On Linux:

```bash
cd ~/projects/
```

Clone via SSH:  

```bash
git clone git@github.com:MichaelAceAnderson/samp-docker.git
```

Clone via HTTPS

```bash
git clone https://github.com/MichaelAceAnderson/samp-docker.git
```

## Installation & Launch

### Build the image locally

To build the image locally, you can run the following command in the right folder (according to your version) of the project:

```bash
docker build . -t samp-server:0.3.7-R2-1
```

### Usage

To use the image, you can run the following command:  
⚠️ **NOTE**: If you are running the image under a WSL environment, UDP ports can't be forwarded to the host machine. You will need to use the IP address of the WSL machine to connect to the server, which can be found by running `ip addr show eth0` in the WSL terminal.

```bash
# ⚠️ It is mandatory to open the UDP port for the server to work properly
# ⚠️ The SAMP_RCON_PASSWORD environment variable has to be different from the default value (changeme) for security reasons
# The server will not run without SAMP_RCON_PASSWORD being set
# Remember to escape special characters in the password (e.g., $ -> \$)
docker run -p 7777:7777/udp -e SAMP_RCON_PASSWORD="n3Wpãs\$w0rD*_''" michaelace/samp-server:0.3.7-R2-1
```

For more informations on how to use the image, please refer to the [Docker Hub page](https://hub.docker.com/r/michaelace/samp-server).

## Project Conventions

### Versioning

This project adheres to [Semantic Versioning](https://semver.org/). The version number is composed of three parts: major, minor, and patch. The version number is incremented according to the following rules:

- Major: making all related apps in previous versions incompatible with the current version
- Minor: added functionality in a backwards-compatible manner
- Patch: backwards-compatible bug fixes

Generally, versions must be incremented according to the following rules:

- breaking change: +1.0.0
- new feature: +0.1.0
- bug fix: +0.0.1
- other (refactor, indentation, ...): +0.0.01

### Git

⚠️ **Warning**: Always test your code and try to remove errors/warnings before commiting and/or submitting a pull request.  

- Commits should clearly describe their content and remain short. The commit message should be in English and include both the type of commit and the scope of the changes. If the change is global or not related to a specific feature/place in the code, the scope is optionnal.  
  ⚠️If the changes are related to an issue, the scope **must** be the issue number.
  - [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
    - `feat(scope)`: new feature (e.g., *feat(#1): authentication*)
    - `fix(scope)`: bug fix (e.g., *fix(#2): fixed communication problem regarding login*)
    - `docs(scope)`: documentation (e.g., *docs(#3): updated README*)
    - `style(scope)`: changes that do not affect the code (spacing, formatting, etc.) (e.g., *style: fixed indentation*)
    - `refactor(scope)`: code changes that neither fix a bug nor add a feature (e.g., *refactor(#5): optimized code*)
    - `perf(scope)`: performance improvement (e.g., *perf(#6): improved speed*)
    - `test(scope)`: adding or modifying tests (e.g., *test(#7): added unit tests*)
    - `conf(scope)`: build configuration changes (e.g., *conf(#8): updated Dockerfile*)
    - `chore(scope)`: changes to the development environment or project organization (e.g., *chore(#9): updated .gitignore*)
- Every branch must be associated with one type of change (see below) and be created from the `develop` branch. Everytime you finish changes on a branch, you must have it reviewed and merged back into `develop` so that the branch can be deleted and the changes can be integrated into the project. When enough features are ready, it is then possible to merge `develop` into `release/x.x.x` depending on the version number, then make small changes on the release branch in case of bugs, and finally merge the release branch into `main` to deploy the changes.
  - [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) (only without the `develop` and `release` branches)
    - `feat/xxxx-name-of-the-feature`: New feature referenced by the issue number and a short description (e.g., `feat/1-authentication`)
    - `fix/xxxx-name-of-the-fix`: Bug fix referenced by the issue number and a short description (e.g., `fix/2-login-error`)
    - `docs/xxxx-name-of-the-docs`: Documentation referenced by the issue number and a short description (e.g., `docs/3-readme`)
    - `style/xxxx-name-of-the-style`: Style changes referenced by the issue number and a short description (e.g., `style/4-indentation`)
    - `refactor/xxxx-name-of-the-refactor`: Refactoring referenced by the issue number and a short description (e.g., `refactor/5-optimization`)
    - `perf/xxxx-name-of-the-perf`: Performance improvement referenced by the issue number and a short description (e.g., `perf/6-speed`)
    - `test/xxxx-name-of-the-test`: Test changes referenced by the issue number and a short description (e.g., `test/7-unit`)

### Code

#### Indentation

Make sure to follow the indentation established by previous users in the files you modify.

#### Code Quality

- Use LF line endings
- Your code must be as modulable and easily reusable as possible.
- Your code must be as self-explanatory as possible. If you cannot find a way to make it so, comment "why" and not "how" you did it
- Explicitly name variables and functions to avoid the need for comments
- File, folder, variable names, and code in general must be in English
- Comments must be in English
- Variables and functions must follow the conventions of their respective languages

### Structure

Here are all the files copied into the container in order for the server to run properly:

- **filterscripts**: Contains the compiled filterscripts
- **gamemodes**: Contains the compiled gamemodes
  - **blank.amx**: A blank gamemode to display an error if none were provided
- **npcmodes**: Contains the recorded NPC scripts
  - **recordings**: Contains the recording files
- **plugins**: Contains the server plugins
- **scriptfiles**: Contains all the files loaded by the gamemode that are not compiled
- **announce**: The announce binary
- **entrypoint.sh**: The entrypoint script
- **samp-npc**: The NPC binary
- **samp03svr**: The server binary
- **server.cfg**: The server configuration file

## Submitting a Pull Request

In order to make a pull request, you need to make sure all the rules in this file have been followed and then fill properly the [pull request template](/.github/pull_request_template.md). Your pull request will then be reviewed and merged if everything is in order. Thank you for your understanding!

## Submitting an Issue

In order to submit an issue, make sure you use the right labels and describe your problem or suggestion as clearly as possible. Your issue will then be reviewed and closed if it is not relevant or fixed/integrated if it is. Thank you for your understanding!
