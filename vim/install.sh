#! /bin/bash

echo "\033[31m Downloading Vim \033[0m"
sudo apt-get install vim

# Install pathogen vim
echo "\033[31m Downloading pathogen-vim \033[0m"
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#Install NERDTree
echo "\033[31m Downloading NERDTree \033[0m"
cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git

#Install Taglist
echo "\033[31m Downloading taglist \033[0m"
cd ~/.vim/bundle && \
wget "http://vim.sourceforge.net/scripts/download_script.php?src_id=19574" -O taglist.zip && \
mkdir taglist && mv taglist.zip taglist/ && unzip taglist/taglist.zip && \
rm taglist/taglist.zip

cp ./.vimrc ~/
