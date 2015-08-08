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

# cleanup
rm tmp{1,2}.txt
rm issues.txt

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
	# get issue num
	read -p "Issue Number: " issue_num

	# get issue detail
	curl https://api.github.com/repos/$username/$repo_name/issues/$issue_num > issues$issue_num.txt

	# format and show detail
	"========================="
	grep 'number' issues$issue_num.txt | tr -d \",
	echo "-------------------------"
	grep 'state' issues$issue_num.txt | tr -d \",
	grep 'closed_at' issues$issue_num.txt | tr -d \",
	grep 'created_at' issues$issue_num.txt | tr -d \",
	grep 'updated_at' issues$issue_num.txt | tr -d \",
	echo "-------------------------"
	grep 'title' issues$issue_num.txt | tr -d \",
	grep 'body' issues$issue_num.txt | tr -d \",
	echo "========================="

	# get new status/title/body
	read -p "New state ( open or closed ): " new_state
	read -p "New title : " new_title
	read -p "New body : " new_body

	# POST
	curl -u $username -i -H "Content-Type: application/json" -X POST --data '{"title":"'$new_title'", "body":"'$new_body'", "state":"'$new_state'"}' https://api.github.com/repos/$username/$repo_name/issues/$issue_num

	# cleanup
	rm issues$issue_num.txt

    ;;
  n)
    ;;
  *)
    ;;
esac

echo


