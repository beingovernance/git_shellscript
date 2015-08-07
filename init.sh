#!/bin/sh
# 
# build.sh
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

# define function
addToGitignore () {

	# add filename to .gitignore
	echo "(hit q for quit)"	
	while :
	do

		read -p "Type file name to add to .gitignore: " filename
		# quit when
		if [ $filename = "q" ]
			then
				break
			else
				echo $filename >> .gitignore
		fi


	done

}

# init
git init

# .gitignore
read -p "Do you want to add .gitignore? (y/n)" answer


case $answer in
  y)
	touch .gitignore
	addToGitignore
    ;;
  n)
    ;;
  *)
    ;;
esac
