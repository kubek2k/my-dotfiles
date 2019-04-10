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
   if [ -z "$OCPR_REVIEWERS" ]; then
     echo "Be advised that there are no reviewers provided"
   fi
   BRANCH_NAME=`echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^A-Za-z]/-/g' | sed -e 's/--*/-/g'`
   git checkout -b "$BRANCH_NAME"
   git add .
   git commit -m "$*"
   git push origin
   hub pull-request -b -a $OCPR_REVIEWERS
}
