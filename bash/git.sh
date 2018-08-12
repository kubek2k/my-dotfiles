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
   BRANCH_NAME=`echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^A-Za-z]/-/g'`
   git checkout -b "$BRANCH_NAME"
   git add .
   git commit -m "$1"
   git push origin
   hub pull-request
}

