#!/bin/bash

# Install compatible CMake
CMake="cmake-3.4.3"

wget -q https://cmake.org/files/v3.4/$CMake.tar.gz
tar xf $CMake.tar.gz
cd $CMake
cmake . > /dev/null
make > /dev/null
sudo make install > /dev/null
echo `cmake --version`

# Determine the correct compiler to install first.
if [ "$CXX" == "g++" ]; then

    # Add required repositories.
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test > /dev/null
    sudo apt-get update -q > /dev/bull

    # Install compiler specific packages.
    sudo apt-get install gcc-5 -qq

    # Ensure the correct compiler is used.
    export CC="gcc-5"
    export CXX="g++-5"

elif [ "$CXX" == "clang++" ]; then

    # Add required repositories.
    sudo add-apt-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main" > /dev/null
    wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
    sudo apt-get update -q > /dev/null

    # Install compiler specific packages.
    sudo apt-get install clang-3.7 -qq

    # Ensure the correct compiler is used.
    export CC="clang-3.7"
    export CXX="clang++-3.7"
fi;
