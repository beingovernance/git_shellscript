#!/bin/sh
# 
# commit.sh
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

# add
git add -A

# commit
read -p "Commit message: " commitMessage
git commit -m "$commitMessage"