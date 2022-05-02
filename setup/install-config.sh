#!/bin/bash

# Add the config to bash
cat ./config-bashrc.txt >> ~/.bashrc

# Reload Bash
exec -l $SHELL