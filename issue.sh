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
curl https://api.github.com/repos/$username/$repo_name/issues > issues.txt

# extract texts
awk '/number/{print $2}' issues.txt > tmp1.txt
awk '/title/{result = ""; for(i=2;i<=NF;++i) result = result " " $i; print result}' issues.txt > tmp2.txt

# formats
echo "========================="
echo "No.\tTitle"
echo "-------------------------"
paste -d"\t" tmp1.txt tmp2.txt | tr -d \",
echo "========================="
rm tmp{1,2}.txt

# curl -i https://api.github.com/repos/$username/$repo_name/issues | grep 'title'| sed s/\"title\"://g
# curl -i https://api.github.com/repos/$username/$repo_name/issues | grep 'number'| sed s/\"number\"://g

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

###################
# edit an issue
###################

# POST
read -p "Do you want to edit issues? (y/n)" answer_edit
case $answer_edit in
  y)
	read -p "Issue Number: " issue_num
	curl https://api.github.com/repos/$username/$repo_name/issues/$issue_num | grep 'title'| sed s/\"title\"://g
    ;;
  n)
    ;;
  *)
    ;;
esac
