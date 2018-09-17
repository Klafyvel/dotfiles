#! /bin/bash

PIP='pip3'
INSTALL='sudo apt install'
PYTHON='python3'

printf "\033[0;32m Downloading Vim \033[0m\n"
$INSTALL vim python3-dev cmake build-essential

printf "\033[0;32m Downloading Vundle \033[0m\n"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

printf "\033[0;32m Downloading autopep8 \033[0m\n"
$PIP install --upgrade autopep8
printf "\033[0;32m Downloading flake8 \033[0m\n"
$PIP install --upgrade flake8

printf "\033[0;32m Copying .vimrc \033[0m\n"
cp .vimrc ~/
printf "\033[0;32m Downloading Vim extensions \033[0m\n"
vim +PluginInstall +qall
printf "\033[0;32m Done \033[0m\n"

printf "\033[0;32m Installing YouCompleteMe \033[0m\n"
$PYTHON ~/.vim/bundle/YouCompleteMe/install.py
