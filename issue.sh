#!/bin/sh
# 
# issue.sh
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

curl -u $username https://api.github.com/user/repos -d '{"name":"'$reponame'"}'
