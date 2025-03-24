#!/usr/bin/env bash
set -euo pipefail

# ts_ls
sudo npm install -g typescript typescript-language-server

# eslint, html, cssls
sudo npm i -g vscode-langservers-extracted

# astro
sudo npm install -g @astrojs/language-server

# angularls
sudo npm install -g @angular/language-server

# lua_ls

# bashls
sudo npm i -g bash-language-server

# rust_analyzer

# yamlls
sudo npm i -g yaml-language-server

# dockerls
npm install -g dockerfile-language-server-nodejs

# pylsp

# clangd

# tailwindcss
sudo npm install -g @tailwindcss/language-server

# templ

# htmx
cargo install htmx-lsp
