#!/bin/bash

git submodule init
git submodule update

cp .gitconfig ~/
cp -rf .vim ~/
cp .vimrc ~/

vim +PluginInstall +qall
