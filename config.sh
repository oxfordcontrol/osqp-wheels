# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.

    # Install CMake
    if [ -n "$IS_OSX" ]; then
	    brew update
	    brew upgrade cmake || brew install cmake
    else
	    export CMAKE_URL="http://www.cmake.org/files/v3.7/cmake-3.7.1-Linux-x86_64.tar.gz"
	    mkdir cmake && wget --quiet -O - ${CMAKE_URL} | tar --strip-components=1 -xz -C cmake
	    export PATH=${TRAVIS_BUILD_DIR}/cmake/bin:${PATH}
    fi
    # export PY_BIN = python -c "import sys; print(sys.executable[:-6])"
    cmake --version
}


function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    # python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
    cd ${TRAVIS_BUILD_DIR}/osqp-python; pytest
}

