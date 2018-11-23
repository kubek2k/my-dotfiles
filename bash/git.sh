# show untracked files as %
export GIT_PS1_SHOWUNTRACKEDFILES=1
# show dirty state as * and added files as +
export GIT_PS1_SHOWDIRTYSTATE=1

# one command pull-request
function ocpr {
   if [ "$1" == "" ]; then
       echo "No message provided" > /dev/stderr
       return 1
   fi
   OCPR_REVIEWERS_FILE="$(git rev-parse --show-toplevel)/.ocpr-reviewers" 
   if [ -f $OCPR_REVIEWERS_FILE ]; then
       REVIEWERS_PARAM="-r `cat $OCPR_REVIEWERS_FILE | paste -sd ',' -`"
   fi
   BRANCH_NAME=`echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^A-Za-z]+/-/g'`
   git checkout -b "$BRANCH_NAME"
   git add .
   git commit -m "$*"
   git push origin
   hub pull-request -o $REVIEWERS_PARAM
}
