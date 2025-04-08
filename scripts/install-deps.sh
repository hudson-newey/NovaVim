#!/usr/bin/env bash
set -euo pipefail

echo "[NovaVim] Installing System Dependencies"

sudo zypper in -y ripgrep nodejs rustup
sudo rustup default stable
