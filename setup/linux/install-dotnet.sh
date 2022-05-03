#!/bin/bash

# Install the dotnet sdk (latest)
echo "Installing latest dotnet release"

# Curl requires the follow redirection command
curl -L https://dot.net/v1/dotnet-install.sh | bash -s -- '-c' 'Current'

