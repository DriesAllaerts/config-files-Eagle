#!/bin/bash

# This script installs OpenFOAM 2.4.x and SOWFA on a linux system
# This script is somewhat of a hack, use as your own risk...

# Set install location
export inst_loc=/home/$USER/OpenFOAM
cd $inst_loc

# Get OpenFOAM-2.4.x
echo Cloning OpenFOAM-2.4.x
git clone https://github.com/OpenFOAM/OpenFOAM-2.4.x.git

# Patch OpenFOAM to use a version of flex higher than 2.5
echo Patching OpenFOAM to use a Flex version higher than 2.5
cd OpenFOAM-2.4.x
find src applications -name "*.L" -type f | xargs sed -i -e 's=\(YY\_FLEX\_SUBMINOR\_VERSION\)=YY_FLEX_MINOR_VERSION < 6 \&\& \1='
cd ..

# Compile OpenFOAM
source OF-2.4.x-env-spack # This script should have been downloaded and should be in the home directory
OpenFOAM-2.4.x-spack
cd OpenFOAM-2.4.x
./Allwmake
cd ..

# Get SOWFA
echo Cloning SOWF
# mv SOWFA SOWFA-install-backup
git clone https://github.com/NREL/SOWFA.git SOWFA-2.4.x

# Patch SOWFA to use correct link directory for compilation
cd SOWFA-2.4.x
find applications src -name "options" -type f | xargs sed -i -e 's\WM_PROJECT_USER_DIR\SOWFA_DIR\g'
cd ..

# Compile SOWFA
cd SOWFA-2.4.x
./Allwmake
cd ..
