
# 
# github.sh
# - create a new repository in Github
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

# get user name
username=`git config github.user`
if [ "$username" = "" ]; then
	echo "Could not find username, run 'git config --global github.user <username>'"
	invalid_credentials=1
fi

# get repo name
dir_name=`basename $(pwd)`
read -p "Do you want to use '$dir_name' as a repo name?(y/n)" answer_dirname
case $answer_dirname in
  y)
	# use currently dir name as a repo name
	reponame=$dir_name
    ;;
  n)
	read -p "Enter your new repository name: " reponame
	if [ "$reponame" = "" ]; then
		reponame=$dir_name
	fi
    ;;
  *)
    ;;
esac


# create repo
echo "Creating Github repository '$reponame' ..."

read -p "Do you want to make it private?(y/n)" answer_private
read -p "Repository Description: " description
read -p "Do you want to add MIT LICENSE template?(y/n)" answer_license

[ $answer_private == y ] && private=true || private=false
[ $answer_license == y ] && license_template="mit" || license_template="unlicense"

curl -u $username https://api.github.com/user/repos -d '{"name":"'$reponame'", "description":"'$description'", "private":"'$private'", "license_template":"'$license_template'"}'
echo " done."

# create empty README.md
echo "Creating README ..."
touch README.md
echo " done."

# create empty .gitignore
echo "Creating .gitignore ..."
touch .gitignore
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
read -p "Do you want to open the new repo page in browser?(y/n): " answer_browser

case $answer_browser in
  y)
	echo "Opening in a browser ..."
	open https://github.com/$username/$reponame
    ;;
  n)
    ;;
  *)
    ;;
esac













