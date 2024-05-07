#!/bin/bash
set -eou pipefail

declare installationLocation="/home/$(whoami)/.local/bin/NovaVim"

echo "Installing to $installationLocation"

mkdir -p $installationLocation
git clone https://github.com/hudson-newey/NovaVim.git $installationLocation

cd $installationLocation
./install.sh
