# Determine the correct compiler to install first.
if [ "$CXX" -eq "g++" ]; then

    # Add required repositories.
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
    sudo apt-get update -q

    # Install compiler specific packages.
    sudo apt-get install gcc-5 -y

    # Ensure the correct compiler is used.
    export CC="gcc-5"
    export CXX="g++-5"

elif [ "$CXX" -eq "clang++"]; then

    # Add required repositories.
    sudo add-apt-repository "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main" -y
    wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
    sudo apt-get update -q

    # Install compiler specific packages.
    sudo apt-get install clang-3.7 -y

    # Ensure the correct compiler is used.
    export CC="clang-3.7"
    export CXX="clang++-3.7"

fi;
