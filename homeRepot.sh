#!/bin/bash

git clone --bare $2 $HOME/.homeRepot
function homeRepot {
   /usr/bin/git --git-dir=$HOME/.homeRepot/ --work-tree=$HOME $@
}
mkdir -p .homeRepotInstall-backup
homeRepot checkout
if [ $? = 0 ]; then
  echo "Checked out homeRepot.";
  else
    echo "Backing up pre-existing dot files.";
    homeRepot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .homeRepotInstall-backup/{}
fi;
homeRepot checkout
homeRepot config --local status.showUntrackedFiles no
