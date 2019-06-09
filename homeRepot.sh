#!/bin/bash

git clone --bare $1 $HOME/.homeRepot
function homeRepot {
	/usr/bin/git --git-dir=$HOME/.homeRepot/ --work-tree=$HOME $@
}
homeRepot checkout 
if [ $? = 0 ]; then
	echo "Checked out homeRepot.";
else
	echo "Backing up pre-existing dot files.";
	FILES=`homeRepot checkout 2>&1 | egrep "\s+\." | awk {'print $1'}`
	for FILE in $FILES
	do
		#echo "File: $FILE"
		DIRNAME=`dirname $FILE`
		#echo "Dirname: $DIRNAME"
		BACKUPDIR=.homeRepotInstallBackup/$DIRNAME
		#echo "Backupdir: $BACKUPDIR"
		mkdir -p $BACKUPDIR
		mv $FILE $BACKUPDIR
	done
fi;
homeRepot checkout
homeRepot submodule init
homeRepot submodule update --recursive
homeRepot config --local status.showUntrackedFiles no
