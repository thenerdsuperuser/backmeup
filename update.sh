#!/bin/bash

#updateFolder
backupFolder='/home/normalguy/Desktop/git/i3'
originalFile='/home/normalguy/.config/i3/config'
backupFile='/home/normalguy/Desktop/git/i3/config'

echo "checks if configs are updated: "

copynew()
{
    echo "Creating local backup..."
	mv $backupFile $backupFile."bak"
	echo "Local backup created."

	echo "Copying updated file..."
	cp $originalFile $backupFile
	echo "Updated the backup file."
}

gitit()
{
  	cd $backupFolder
  	git init;
	git add .;
	git commit -m "Updated files on `date +'%Y-%m-%d %H:%M:%S'`";
	git push origin master;
}


if output=$(diff -wB $originalFile $backupFile)  &&  [ -z "$output" ]; 
then 
  echo "No change in the files.";
  update=0
else 
  echo "Changes made in the file.";
  update=1
fi


case $update in
  0) echo "Don't backup."
	;;
  1) echo "Back it up."
	copynew
	gitit
	;;
esac


# read -s pass 			# -s is secure

# echo -n "pass: "; read -s pass; echo -n -e "\nyour pass is: "; echo $pass;

