# .bash_profile


# Get functions in .bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


# Get aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


## User specific environment and startup programs

export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

## Add pylib/bin with Eliot's tools to PATH
export PATH=$PATH:$HOME/tools/pylib/bin
## Add datatools/utilities to PATH
export PATH=$PATH:$HOME/tools/datatools/utilities

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
    module load conda
    source activate py3env
    export PYTHONPATH=$PYTHONPATH:/home/dallaert/tools
}


# Copy OpenFOAM simulation directory structure
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


# Start interactive job in debug partition
# Limits:
# - 1 node per user
# - 24 hour walltime max
idebug() {
    case $# in
    "0" )
        echo "Requesting 1 node with 36 processors for 4 h in debug partition"
        salloc --nodes=1 --ntasks-per-node=36 --time=4:00:00 --account=mmc --partition=debug
        ;;
    "1" )
        if [ $1 -gt 24 ]; then
            echo "Max walltime in debug partition is 24 h"
            return 1
        
        fi

        echo "Requesting 1 node with 36 processors for $1 h in debug partition"
        salloc --nodes=1 --ntasks-per-node=36 --time=$1:00:00 --account=mmc --partition=debug
        ;;
    * )
        echo "I don't know what these options mean"
    esac
}


# Start interactive job
ijob() {
    case $# in
    "0" )
        idebug
        ;;
    "2" )
        echo "Requesting $1 node(s) with $2 processor(s) for 4 h"
        salloc --nodes=$1 --ntasks-per-node=$2 --time=4:00:00 --account=mmc
        ;;
    "3" )
        echo "Requesting $1 node(s) with $2 processor(s) for $3 h"
        salloc --nodes=$1 --ntasks-per-node=$2 --time=$3:00:00 --account=mmc
        ;;
    * )
        echo "I don't know what these options mean"
    esac
}

# Paraview
Paraview-5.6.0()
{
   module purge
   module load openmpi/3.1.3/gcc-7.3.0
   export PATH=/home/mchurchf/packages/ParaView-5.6.0-MPI-Linux-64bit/bin:$PATH
   export LD_LIBRARY_PATH=/home/mchurchf/packages/ParaView-5.6.0-MPI-Linux-64bit/lib:$LD_LIBRARY_PATH
  #export LD_LIBRARY_PATH=/nopt/torque/lib:$LD_LIBRARY_PATH
}



# Nalu
Nalu-wind()
{
   source /projects/hfm/shreyas/exawind/scripts/exawind-env-gcc.sh
}



# OpenFOAM
source /nopt/nrel/ecom/wind/OpenFOAM/OF-2.4.x-env-central
source /nopt/nrel/ecom/wind/OpenFOAM/OF-6-env-central
source /nopt/nrel/ecom/wind/OpenFOAM/OF-v1812-env-central
source /home/$USER/OpenFOAM/scripts/OF-2.4.x-env-pro
source /home/$USER/OpenFOAM/scripts/OF-2.4.x-env-dev
source /home/$USER/OpenFOAM/scripts/OF-6-env-dev
#source /home/$USER/OpenFOAM/scripts/OF-v1812-env-dev
