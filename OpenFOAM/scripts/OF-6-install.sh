#!/bin/bash

# This script installs OpenFOAM 2.4.x and SOWFA on a linux system
# This script is somewhat of a hack, use as your own risk...

# Set install location
export inst_loc=/home/$USER/OpenFOAM
cd $inst_loc

# Get OpenFOAM-6
echo Cloning OpenFOAM-6
git clone https://github.com/OpenFOAM/OpenFOAM-6.git

# Compile OpenFOAM
source OF-6-env-spack # This script should have been downloaded and should be in the home directory
OpenFOAM-6-spack
cd OpenFOAM-6
./Allwmake
cd ..
