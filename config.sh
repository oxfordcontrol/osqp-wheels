# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
	# Any stuff that you need to do before you start building the wheels
	# Runs in the root directory of this repository.

	# Fix cmake installation
	PYBIN=`python -c 'import sys; print(sys.executable[:-6])'`
	ln -sf $PYBIN/cmake /usr/bin/cmake
	CMAKE_FIX="#!/$PYBIN/python"
	sed -i "1s/.*/$CMAKE_FIX/" /usr/bin/cmake
}


function run_tests {

	# Runs tests on installed distribution from an empty directory
	python --version
	# python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
	cd ${TESTS_DIR}; python -m pytest -k 'not mkl_'
}
