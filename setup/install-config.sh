#!/bin/bash

# Add the config to bash
cat ./config/config-base.txt >> ~/.bashrc
cat ./config/config-dotnet.txt >> ~/.bashrc

# Reload Bash
exec -l $SHELL
