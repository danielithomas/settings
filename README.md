# Settings

Scripts and Setups that can be used across multiple environments

The settings project contains several key areas:
1. `setup` - go here when setting up a fresh environment
1. `scripts` - base scripts 

## What you get

Some old terminal favourites and some applications that get my environment up and running. 

## Installing

1. Clone this repo into your home directory: `git clone https://github.com/danielithomas/settings.git` which creates the settings directory. 
1. Inside there, make sure the file `settings\setup\install-scripts.sh` is executable then run that. 

Important Note: Scripts assume you have a "config" directory at `~/config` - the script doesn't create this at the moment (I used to use symlinks which were specific to my workflow) so remember to `mkdir config` in your home directory.

## Works with 

## Debian-based Linux Distros

Primary assumptions being made here are that the linux distro is debian or debian based. Scripts also install from snaps, and makes a try to install that if not present. Right now, this is my primary focus. 

### WSL

TODO

### Raspberry Pi

TODO - Yet to test on my home Pi. I think the script would need to be more robust to know what works and what doesn't on Raspian (64-bit)

## Windows

TODO

## Mac 

Mostly there... Removed a lot of custom aliases.

