# Shell scripts for Git

### About

Shell scripts for manipulating your Git repository. 

- [Github](https://github.com/KENJU/git_shellscript)
- [Documentation](http://kenju.github.io/git_shellscript/)

### Usage

Download a shell script whilch you want to use into your git repository, and then add permission for executing files with below commands.

```bash
$ chmod u+x init.sh
``` 

## List

- init.sh
- commit.sh
- push.sh
- build.sh
- github.sh
- issue.sh
	- issue_list.sh
	- issue_create.sh
	- issue_edit.sh

### init.sh

- `git init`
- create `.gitignore`
- add file name to .gitignore

```sh

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

```

### commit.sh

- just add all files
- commit with commit messages

```sh

# add
git add -A

# commit
read -p "Commit message: " commitMessage
git commit -m "$commitMessage"

```

### push.sh

- commit.sh
- + can add tag
- + push

```sh

# ( commit.sh... )

# add tag
read -p "Do you want to add tag? (y/n)" answer

case $answer in
  y)
    # show all tags
    git tag
    # add a new tag
    read -p "Tag Version: " tagVersion
    read -p "Tagging Message: " taggingMessage
    git tag -a $tagVersion -m "$taggingMessage"
    git push --tags
    ;;
  n)
    ;;
  *)
    ;;
esac

# push
git push

```

### build.sh

- push.sh
- + push to `gh-pages` branch

```sh

# ( push.sh... )

# build
git checkout gh-pages
git rebase master
git push origin gh-pages
git checkout master

```

### github.sh

- create a new repo in Github
- git init yoru current directory
- git push to the newly created repo

```sh

#!/bin/sh
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


```

### issue.sh

- list all issues of your current repository
- add a new issue
- edit issues

#### issue_list.sh

```sh

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
curl -i https://api.github.com/repos/KENJU/$repo_name/issues | grep 'title'| sed s/\"title\"://g

```

#### issue_create.sh

```sh

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

```

#### issues_edit.sh

