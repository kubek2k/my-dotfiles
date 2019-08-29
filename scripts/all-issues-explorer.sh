#!/bin/bash

bind '"\C-k": "pwd\n"'

while [ true ]; do
  ISSUE_URL=`get-all-issues.sh | fzf | rev | cut -f1 -d, | rev`
  ISSUE_OWNER=`echo $ISSUE_URL | rev | cut -f4 -d/ | rev`
  ISSUE_REPO=`echo $ISSUE_URL | rev | cut -f3 -d/ | rev`
  ISSUE_ID=`echo $ISSUE_URL | rev | cut -f1 -d/ | rev`
  if [ ! -z "$ISSUE_ID" ]; then
    show-issue.sh $ISSUE_OWNER $ISSUE_REPO $ISSUE_ID | mdless
  else
    break
  fi
done
