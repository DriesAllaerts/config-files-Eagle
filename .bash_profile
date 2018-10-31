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

# Also load candidate modules.
module use -a /nopt/nrel/apps/modules/candidate/modulefiles
module use -a /nopt/nrel/apps/modules/default/modulefiles

# Functions to easily load various software.
# For setting python environment
sourcePYTHON3()
{
    module purge
    module load conda/5.1
    source activate py3env
    export PYTHONPATH=/home/dallaert/pytools:/home/dallaert/PostTools:$PYTHONPATH
    export PATH=/home/dallaert/PostTools:$PATH
    export PATH=/home/dallaert/PostTools/datatools/utilities:$PATH
}

# Paraview
Paraview-5.0.0()
{
   module purge
   module load openmpi-gcc/1.6.4-4.8.1
   export PATH=/home/mchurchf/bin/ParaView-5.0.0-Qt4-OpenGL2-MPI-Linux-64bit/bin:$PATH
   export LD_LIBRARY_PATH=/home/mchurchf/bin/ParaView-5.0.0-Qt4-OpenGL2-MPI-Linux-64bit/lib:$LD_LIBRARY_PATH
   export LD_LIBRARY_PATH=/nopt/torque/lib:$LD_LIBRARY_PATH
}

Paraview-5.5.2()
{
   module purge
   module load openmpi-gcc/2.1.2-7.2.0
   export PATH=/home/mchurchf/bin/ParaView-5.5.2-Qt5-MPI-Linux-64bit/bin:$PATH
   export LD_LIBRARY_PATH=/home/mchurchf/bin/ParaView-5.5.2-Qt5-MPI-Linux-64bit/lib:$LD_LIBRARY_PATH
   export LD_LIBRARY_PATH=/nopt/torque/lib:$LD_LIBRARY_PATH
}

#OpenFOAM

# OpenFOAM-2.4.x (central compile for all windsim users)
OpenFOAM-2.4.x-central()
{
   # Unset OpenFOAM environment variables.
   if [ -z "$FOAM_INST_DIR" ]; then
      echo "Nothing to unset..."
   else  
      echo "Unsetting OpenFOAM environment variables..."
      . $FOAM_INST_DIR/OpenFOAM-$OPENFOAM_VERSION/etc/config/unset.sh
   fi

   # Unload any compilers already loaded
   echo "Purging modules..."
   module purge

   # Load the appropriate compiler
   echo "Loading compilers..."
   module load openmpi-gcc/1.7.3-4.8.2
   module load mkl/13.5.192
   module load cmake/3.7.2
   module list

   # Set the OpenFOAM version and installation directory
   export OPENFOAM_VERSION=2.4.x
   export OPENFOAM_NAME=OpenFOAM-$OPENFOAM_VERSION
   export FOAM_INST_DIR=/projects/windsim/OpenFOAM

   foamDotFile=$FOAM_INST_DIR/$OPENFOAM_NAME/etc/bashrc
   if [ -f $foamDotFile ] ; then
      echo "Sourcing $foamDotFile..."
      source $foamDotFile
   fi
   export WM_PROJECT_USER_DIR=$FOAM_INST_DIR/SOWFA-$OPENFOAM_VERSION
   export WM_NCOMPPROCS=12
   export WM_COLOURS="white blue green cyan red magenta yellow"
   export OPENFAST_DIR=$FOAM_INST_DIR/openfast-openmpi-gcc-1.7.3-4.8.2/install
   export HDF5_DIR=$FOAM_INST_DIR/openfast-openmpi-gcc-1.7.3-4.8.2/install
   export FOAM_USER_LIBBIN=$WM_PROJECT_USER_DIR/lib/$WM_OPTIONS
   export FOAM_USER_APPBIN=$WM_PROJECT_USER_DIR/applications/bin/$WM_OPTIONS
   export FOAM_RUN=$WM_PROJECT_USER_DIR/run
   export LD_LIBRARY_PATH=$FOAM_USER_LIBBIN:$LD_LIBRARY_PATH
   export LD_LIBRARY_PATH=$OPENFAST_DIR/lib/:$LD_LIBRARY_PATH
   export PATH=$FOAM_USER_APPBIN:$PATH
}

# OpenFOAM-2.4.x (local compile with personal version of SOWFA)
OpenFOAM-2.4.x-local()
{
   if [ $# == 0 ]; then
       export SOWFA_VERSION=SOWFA
   else
       export SOWFA_VERSION=$1
   fi

   # Unset OpenFOAM environment variables.
   if [ -z "$FOAM_INST_DIR" ]; then
      echo "Nothing to unset..."
   else
      echo "Unsetting OpenFOAM environment variables..."
      . $FOAM_INST_DIR/OpenFOAM-$OPENFOAM_VERSION/etc/config/unset.sh
   fi

   # Unload any compilers already loaded
   echo "Purging modules..."
   module purge

   # Load the appropriate modules
   echo "Loading modules..."
   module load openmpi-gcc/1.7.3-4.8.2
   module load mkl/13.5.192
   module load cmake/3.7.2
   module list

   # Set the OpenFOAM version and installation directory
   export OPENFOAM_VERSION=2.4.x
   export OPENFOAM_NAME=OpenFOAM-$OPENFOAM_VERSION
   export FOAM_INST_DIR=$HOME/OpenFOAM

   foamDotFile=$FOAM_INST_DIR/$OPENFOAM_NAME/etc/bashrc
   if [ -f $foamDotFile ] ; then
      echo "Sourcing $foamDotFile..."
      source $foamDotFile
   fi
   export WM_PROJECT_USER_DIR=$FOAM_INST_DIR/$SOWFA_VERSION
   echo "Using SOWFA distribution in $WM_PROJECT_USER_DIR"
   export WM_NCOMPPROCS=12
   export WM_COLOURS="white blue green cyan red magenta yellow"
   export OPENFAST_DIR=$FOAM_INST_DIR/openfast-openmpi-gcc-1.7.3-4.8.2/install
   export HDF5_DIR=$FOAM_INST_DIR/openfast-openmpi-gcc-1.7.3-4.8.2/install
   export FOAM_USER_LIBBIN=$WM_PROJECT_USER_DIR/lib/$WM_OPTIONS
   export FOAM_USER_APPBIN=$WM_PROJECT_USER_DIR/applications/bin/$WM_OPTIONS
   export FOAM_RUN=$WM_PROJECT_USER_DIR/run
   export LD_LIBRARY_PATH=$FOAM_USER_LIBBIN:$LD_LIBRARY_PATH
   export LD_LIBRARY_PATH=$OPENFAST_DIR/lib/:$LD_LIBRARY_PATH
   export PATH=$FOAM_USER_APPBIN:$PATH
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

function nalu_env {
    module purge
    # Load the python environment
    module load conda
    source activate nalu_python

    local mod_dir=/nopt/nrel/ecom/ecp/base/modules/
    module use ${mod_dir}/gcc-6.2.0
    module load gcc/6.2.0

    compiler=${1:-gcc}

    case ${compiler} in
       gcc)
           module unuse ${mod_dir}/intel-18.1.163
           module load binutils openmpi/3.1.1 netlib-lapack cmake
           ;;
       intel)
           module load intel-parallel-studio/cluster.2018.1
           module use ${mod_dir}/intel-18.1.163
           module load binutils intel-mpi intel-mkl cmake
           ;;
    esac
}

# Start interactive job
ijob() {
 
    case $# in
    "0" )
      echo "Requesting 1 node with 24 procs for 4 h in queue short"
      qsub -V -I -l nodes=1:ppn=24,walltime=4:00:00 -A windsim -q short
      ;;
    "2" )
      echo "Requesting $1 node(s) with $2 proc(s) for 4 h in queue short"
      qsub -V -I -l nodes=$1:ppn=$2,walltime=4:00:00 -A windsim -q short
      ;;
    "3" )
      echo "Requesting $1 node(s) with $2 proc(s) for $3 h in queue short"
      qsub -V -I -l nodes=$1:ppn=$2,walltime=$3:00 -A windsim -q short
      ;;
    "4" )
      echo "Requesting $1 node(s) with $2 proc(s) for $3 h in queue $4"
      qsub -V -I -l nodes=$1:ppn=$2,walltime=$3:00 -A windsim -q $4
      ;;
    * )
      echo "I don't know what these options mean"
    esac
}

## User specific environment and startup programs
#
#PATH=$PATH:$HOME/.local/bin:$HOME/bin
#
#export PATH
