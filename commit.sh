#!/bin/sh

# add all files in the current directory
git add -A

# read commit message
read -p "Commit message: " commitMessage
git commit -m "$commitMessage"
