# Shell scripts for Git

### About

Shell scripts for manipulating your Git repository. 

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