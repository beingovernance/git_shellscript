#!/bin/sh
# 
# github.sh
# - create a new repository in Github
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

# read from command line
# read -p "Enter your Github username: " username
read -p "Enter your new repository name: " reponame

# create repo
echo "Creating Github repository '$reponame' ..."
curl -u $username https://api.github.com/user/repos -d '{"name":"'$reponame'"}'
echo " done."

# create empty README.md
echo "Creating README ..."
touch README.md
echo " done."

# push to remote repo
echo "Pushing to remote ..."
git init
git add -A
git commit -m "first commit"
git remote rm origin
git remote add origin https://github.com/$username/$reponame.git
git push -u origin master
echo " done."

# open in a browser
read -p "Do you want to open the new repo page in browser?(y/n): " answer

case $answer in
  y)
	echo "Opening in a browser ..."
	open https://github.com/$username/$reponame
    ;;
  n)
    ;;
  *)
    ;;
esac


curl -sL --user "${username}:${password}" https://api.github.com/user/repos -d '{"name":"awesome"}'

curl -sL --user "${username}:${password}" https://github.com/$account/$repo/tarball/$tag_name > tarball.tar

curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1

curl -u "${username}:${password}" https://api.github.com/user/repos -d '{"name":"awesome"}'













