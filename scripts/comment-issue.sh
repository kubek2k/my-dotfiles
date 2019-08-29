#!/bin/bash

if [ $# -ne 3 ]; then
  echo "$0 <repo_owner> <repo> <number>" > /dev/stderr
  exit 1
fi

COMMENT_BODY_FILE=`mktemp /tmp/comment-issues-XXXXX.txt`

nvim $COMMENT_BODY_FILE
if [ -f $COMMENT_BODY_FILE ]; then
  if [ -z "$(cat $COMMENT_BODY_FILE)" ]; then
    echo "Comment file is empty. Aborting."
    exit 1
  fi
fi
hub api "repos/${1}/${2}/issues/${3}/comments" -F "body=@${COMMENT_BODY_FILE}"
rm $COMMENT_BODY_FILE
