# dotfiles

My personal configuration for macOS, terminal setup, and dev environment.

# config.sh

Automatigically configure a new Mac in one command, out of the box, with no prerequisites.

Pulled a ton of stuff from my own research, but a lot of the macOS config comes from these two:

[Mathis Byens's dotfiles](https://github.com/mathiasbynens/dotfiles)

[OSX for Hackers](https://gist.github.com/brandonb927/3195465)

# Installation:

## **BACKUP** your files.

This script will not *remove* anything on your computer, but it will overwrite some things you may have configured.

I recommend a full time machine backup for your system just in case, but at the very least you should backup your current dotfiles (.bashrc, .vimrc, .bash_profile, etc.). These will all be overwritten if you run config.sh without customization. See the step below for exactly what gets configured.

## Read the configure script before you attempt anything.

I don't take responsibility for anything that happens to your machine.

**PLEASE back up your Mac!**

## Customization

If for any reason you don't like what a line does, aren't sure what it will do, or otherwise have any concerns, PM me, create an issue, pull request, or fork this repo and comment it out.

## To Install:

Simply copy and paste into Terminal. Sit back and enjoy.

`curl -L https://raw.githubusercontent.com/kevinschaich/dotfiles/master/config.sh | sh`
