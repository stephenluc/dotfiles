#!/bin/bash

cd "$(dirname "$0")"

sh ./link-dotfiles.sh
sh ./dev-tools-setup.sh
sh ./github-ssh-setup.sh
