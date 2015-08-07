#!/bin/sh
# 
# github.sh
# - create a new repository in Github
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

read -p "Enter your Github username: " username
read -p "Enter your new repository name: " reponame
curl -u $username https://api.github.com/user/repos -d '{"name":$reponame}'

touch README.md

git init
git add -A
git commit -m "first commit"
git remote add origin https://github.com/$username/$reponame.git
git push -u origin master

read -p "Do you want to open the new repo page in browser?(y/n): " answer

case $answer in
  y)
	open https://github.com/$username/$reponame
    ;;
  n)
    ;;
  *)
    ;;
esac
