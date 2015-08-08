#!/bin/sh
# 
# issue.sh
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 
#
# @see
# https://developer.github.com/v3/issues/

###################
# list issues
###################

# get user name
username=`git config github.user`
if [ "$username" = "" ]; then
	echo "Could not find username, run 'git config --global github.user <username>'"
	invalid_credentials=1
fi

# get repository name
repo_name=`basename $(git rev-parse --show-toplevel)`

# list all issue
curl -i https://api.github.com/repos/$username/$repo_name/issues > issues.txt
awk '/title/{print $2}' issues.txt > tmp1.txt
awk '/number/{print $2}' issues.txt > tmp2.txt
paste -d":" tmp1.txt tmp2.txt

curl -i https://api.github.com/repos/$username/$repo_name/issues | grep 'title'| sed s/\"title\"://g
curl -i https://api.github.com/repos/$username/$repo_name/issues | grep 'number'| sed s/\"number\"://g

###################
# create an issue
###################

# POST
read -p "Do you want to add issues? (y/n)" answer_add
case $answer_add in
  y)
	read -p "Issue Title: " title
	read -p "Issue Body: " body
	curl -u $username -i -H "Content-Type: application/json" -X POST --data '{"title":"'$title'", "body":"'$body'"}' https://api.github.com/repos/$username/$repo_name/issues
    ;;
  n)
    ;;
  *)
    ;;
esac
