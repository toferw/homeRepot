#!/bin/bash

git clone --bare $1 $HOME/.homeRepot
function homeRepot {
	/usr/bin/git --git-dir=$HOME/.homeRepot --work-tree=$HOME $@
}
homeRepot checkout
if [ $? = 0 ]; then
	echo "Checked out homeRepot.";
	homeRepot submodule init
	homeRepot submodule update
	homeRepot config --local status.showUntrackedFiles no
else
	echo "Backing up pre-existing dot files.";
	FILES=`homeRepot checkout 2>&1 | egrep "^\s+.+" | awk {'print $1'}`
	for FILE in $FILES
	do
		#echo "File: $FILE"
		DIRNAME=`dirname $FILE`
		#echo "Dirname: $DIRNAME"
		BACKUPDIR=.backupHomeRepotInstall/$DIRNAME
		#echo "Backupdir: $BACKUPDIR"
		mkdir -pv $BACKUPDIR
		mv -v $FILE $BACKUPDIR
	done
	echo "Trying again...";
	homeRepot checkout
	if [ $? = 0 ]; then
		echo "Checked out homeRepot.";
		homeRepot submodule init
		homeRepot submodule update
		homeRepot config --local status.showUntrackedFiles no
	else
		echo "Things went horribly, horribly wrong...";
	fi;
fi;
