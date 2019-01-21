# .bash_profile

# Get functions in .bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


# Get aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


# get current branch in git repo
function parse_git_branch() {
BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
if [ ! "${BRANCH}" == "" ]; then
  STAT=`parse_git_dirty`
  echo "[${BRANCH}${STAT}]"
else
  echo ""
fi
}


# get current status of git repo
function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}


# Enable git branch display in bash prompt
gitactivate()
{
  export PS1=': \u@\[\e[1;31m\]\h\[\e[0m\] \w `parse_git_branch` `date +%H:%M` $ '
}


# Disable git branch display in bash prompt and revert to standard prompt
gitdeactivate()
{
  export PS1=': \u@\[\e[1;31m\]\h\[\e[0m\] \w `date +%H:%M` $ '
}


# Configure the shell environment
  #export PS1="\u@\w \`parse_git_branch\`$ "
  export PS1=': \u@\[\e[1;31m\]\h\[\e[0m\] \w `date +%H:%M` $ '
  #export PS1=': \u@\[\e[1;31m\]\h\[\e[0m\] \w `parse_git_branch` `date +%H:%M` $ '
  export EDITOR=/usr/bin/vim
  export BLOCKSIZE=1k # Set default blocksize for ls, df, du, from this: http://hints.macworld.com/comment.php?mode=view&cid=24491


# Functions to easily load various software.
# For setting python environment
sourcePYTHON3()
{
    module purge
    module load conda/5.1
    source activate py3env
    export PYTHONPATH=/home/dallaert/Python:/home/dallaert/PostTools:$PYTHONPATH
    export PATH=/home/dallaert/PostTools:$PATH
    export PATH=/home/dallaert/PostTools/datatools/utilities:$PATH
}


foamCopyCase()
{
    if [ $# -lt 2 ]; then
        echo "Please specify source and destination directory"
        return 1
    fi

    if [ ! -d $1 ]; then
        echo "Error: source directory not found"
        return 1
    fi

    if [ -d $2 ]; then
        echo "Error: destination directory already exists"
        return 1
    fi

    mkdir $2
    cd $2
    cp -r ../$1/constant .
    cp -r ../$1/system .
    cp -r ../$1/0.original .
    cp -r ../$1/setUp .
    cp -r ../$1/runscript.solve.1 .
    cp -r ../$1/runscript.preprocess .
    ls
}


## User specific environment and startup programs
#
#PATH=$PATH:$HOME/.local/bin:$HOME/bin
#
#export PATH
