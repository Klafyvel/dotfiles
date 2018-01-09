#! /bin/bash

echo "\033[31m Downloading Vim \033[0m"
sudo apt install vim

echo "\033[31m Downloading Vundle \033[0m"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "\033[31m Downloading autopep8 \033[0m"
pip install --upgrade autopep8
echo "\033[31m Downloading flake8 \033[0m"
pip install --upgrade flake8

echo "\033[31m Copying .vimrc \033[0m"
cp .vimrc ~/
echo "\033[31m Downloading Vim extensions \033[0m"
vim +PluginInstall +qall
echo "\033[31m Done \033[0m"

echo "\033[31m Installing YouCompleteMe \033[0m"
exec ~/.vim/bundle/YouCompleteMe/install.sh
