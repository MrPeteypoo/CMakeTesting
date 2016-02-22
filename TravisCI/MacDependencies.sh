#!/bin/bash

# Utility functions.
install ()
{
    echo "Installing $1..."
    brew install $1
}
upgrade ()
{
    echo "Upgrading $1..."
    brew outdated $1 || brew upgrade $1
}


# Required packages.
CMake="cmake"
GCC="gcc5"
Clang="llvm37 --with-lld"

echo "Updating packages..."
brew update
brew tap homebrew/versions

upgrade $CMake


# Determine the correct compiler to install.
if [ "$CXX" == "g++" ]; then
    install $GCC

elif [ "$CXX" == "clang++" ]; then
    install $Clang
fi;
