#!/bin/bash

cp -rf .vim ~/
cp .vimrc ~/

vim +PluginInstall +qall
