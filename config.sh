# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]
CMAKE_VER_MAJ="3"
CMAKE_VER_MIN="9"
CMAKE_VER_PATCH="2"
CMAKE_VER_FULL="${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH}"
TESTS_DIR="$(pwd)/osqp-python"

function pre_build {
	# Any stuff that you need to do before you start building the wheels
	# Runs in the root directory of this repository.


	# Install CMake
	if [ -n "$IS_OSX" ]; then
		brew update
		brew upgrade cmake || brew install cmake
	else
		CMAKE_NAME="cmake-${CMAKE_VER_FULL}-Linux-x86_64"
		CMAKE_URL="http://www.cmake.org/files/v${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}/${CMAKE_NAME}.tar.gz"
		fetch_unpack ${CMAKE_URL}
		export PATH=`pwd`/${CMAKE_NAME}/bin:${PATH}
		# # Build zlib (required by cmake)
		# build_zlib
		# fetch_unpack http://www.cmake.org/files/v${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}/cmake-${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH}.tar.gz
		# (cd cmake-${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}.${CMAKE_VER_PATCH} \
			#     && ./bootstrap --system-curl \
			#     && make \
			#     && make install)
	fi
	cmake --version
}


function run_tests {
	# Add Cmake to docker
	CMAKE_NAME="cmake-${CMAKE_VER_FULL}-Linux-x86_64"
	CMAKE_URL="http://www.cmake.org/files/v${CMAKE_VER_MAJ}.${CMAKE_VER_MIN}/${CMAKE_NAME}.tar.gz"
	fetch_unpack ${CMAKE_URL}
	export PATH=`pwd`/${CMAKE_NAME}/bin:${PATH}
	cmake --version

	# Runs tests on installed distribution from an empty directory
	python --version
	# python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
	cd ${TESTS_DIR}; python -m pytest
}

