#!/bin/bash

# Utility functions.
install()
{
    echo "Installing $1..."
    sudo apt-get install $1 -qq &> /dev/null
}


# Required dependencies.
Curl="libcurl4-openssl-dev"
CMake="cmake-3.4.3"
GCC="gcc-5"
Clang="clang-3.7"
OpenGL="lib-gl1-mesa-dev"
RandR="libxrandr-dev"
Xinerama="libxinerama-dev"
Xcursor="libxcursor-dev"


# Upgrade the installed CMake version, depends on Curl for OpenSSL support on linux.
sudo apt-get update -qq
install $Curl

echo "Downloading $CMake..."
wget -q https://cmake.org/files/v3.4/$CMake.tar.gz
tar xf $CMake.tar.gz

echo "Configuring $CMake..."
cd $CMake
cmake . -DCMAKE_USE_OPENSSL:BOOL=ON > /dev/null

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
    install $GCC

elif [ "$CXX" == "clang++" ]; then

    echo "Adding required repositories..."
    wget -q -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
    sudo add-apt-repository -y "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main" > /dev/null

    echo "Updating packages..."
    sudo apt-get update -qq
    install $Clang
fi;


# Install dependencies unrelated to the compiler choice.
install $OpenGL
install $RandR
install $Xinerama
install $Xcursor

echo "Dependencies processed."
