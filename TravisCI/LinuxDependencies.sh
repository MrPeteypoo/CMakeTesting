#!/bin/bash

# Version requirements here.
CMake="cmake-3.4.3"
GCC="gcc-5"
Clang="clang-3.7"

echo "Downloading $CMake..."
wget -q https://cmake.org/files/v3.4/$CMake.tar.gz
tar xf $CMake.tar.gz

echo "Configuring $CMake..."
cd $CMake
cmake . > /dev/null

echo "Attempting to build $CMake..."
make > /dev/null

echo "Attempting to upgrade $CMake..."
sudo make install > /dev/null

# Determine the correct compiler to install.
if [ "$CXX" == "g++" ]; then

    echo "Adding required repositories..."
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test > /dev/null

    echo "Updating packages..."
    sudo apt-get update -qq

    echo "Installing $GCC..."
    sudo apt-get install $GCC -qq &> /dev/null

elif [ "$CXX" == "clang++" ]; then

    echo "Adding required repositories..."
    wget -q -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
    sudo add-apt-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main" > /dev/null

    echo "Updating packages..."
    sudo apt-get update -qq

    echo "Installing $Clang..."
    sudo apt-get install $Clang -qq &> /dev/null
fi;

echo "Dependencies processed."
