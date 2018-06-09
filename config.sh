# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]
CMAKE_VER_MAJ="3"
CMAKE_VER_MIN="7"
CMAKE_VER_PATCH="2"
TESTS_DIR="$(pwd)/osqp-python"

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.

    # Install CMake
    if [ -n "$IS_OSX" ]; then
	    brew update
	    brew upgrade cmake || brew install cmake
    else
	  # Build zlib (required by cmake)
	  build_zlib
	  fetch_unpack http://www.cmake.org/files/v${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}/cmake-${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH}.tar.gz
	  (cd cmake-${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH} \
	      && ./bootstrap --system-curl \
	      && make \
	      && make install)
    fi
    cmake --version
}


function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    # python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
    cd ${TESTS_DIR}; pytest
}

