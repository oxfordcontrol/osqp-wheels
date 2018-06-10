# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]
CMAKE_VER_MAJ="3"
CMAKE_VER_MIN="9"
CMAKE_VER_PATCH="2"
CMAKE_VER_FULL="${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH}"
TESTS_DIR="$(pwd)/osqp-python"


function install_cmake {
	# Install CMake
	if [ -n "$IS_OSX" ]; then
		brew update
		brew upgrade cmake || brew install cmake
	else
		# Build cmake and zlib (required by cmake)
		yum install -y zlib-dev
		fetch_unpack http://www.cmake.org/files/v${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}/cmake-${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH}.tar.gz
		(cd cmake-${CMAKE_VER_FULL} \
			    && ./bootstrap --system-curl \
			    && make \
			    && make install)
	fi


        # Check cmake version
	cmake --version
}


function pre_build {
	# Any stuff that you need to do before you start building the wheels
	# Runs in the root directory of this repository.
	# install_cmake
	:
}


function run_tests {

        # Get python binary location and add it to the path
	PYBIN=`python -c 'import sys; print(sys.executable[:-6])'`
	rm -rf /usr/local/bin/cmake
	ln -s $PYBIN/cmake /usr/local/bin/cmake

        # Check cmake version
	cmake --version

	# Runs tests on installed distribution from an empty directory
	python --version
	# python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
	cd ${TESTS_DIR}; python -m pytest
}

