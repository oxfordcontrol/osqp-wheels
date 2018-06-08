# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]
CMAKE_VERSION="3.7.1"

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.

    # Install CMake
    if [ -n "$IS_OSX" ]; then
	    brew update
	    brew upgrade cmake || brew install cmake
    else
	    fetch_unpack http://www.cmake.org/files/v3.7/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz
	    export PATH=`pwd`/cmake-${CMAKE_VERSION}-Linux-x86_64/bin:${PATH}
    fi
    cmake --version
}


function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    # python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
    cd ${TRAVIS_BUILD_DIR}/osqp-python; pytest
}

