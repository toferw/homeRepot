#!/bin/bash

git init --bare $HOME/.homeRepot
alias homeRepot='/usr/bin/git --git-dir=$HOME/.homeRepot/ --work-tree=$HOME'
homeRepot config --local status.showUntrackedFiles no
echo "alias homeRepot='/usr/bin/git --git-dir=$HOME/.homeRepot/ --work-tree=$HOME'" >> $HOME/.bashrc
