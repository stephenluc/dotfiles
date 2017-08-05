#!/bin/bash

cp ~/.vimrc ./
cp -rf ~/.vim ./
rm .vim/.netrwhist
cp ~/.gitconfig ./

git s
