#!/bin/bash
set -eou pipefail
git pull origin main
./install.sh
