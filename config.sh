# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]
TESTS_DIR="$(pwd)/osqp-python"

function fix_cmake {
	if [ -n "$IS_OSX" ]; then
		brew update
		brew upgrade cmake || brew install cmake
	else
		# Fix cmake installation linking the appropriate binary
		pip install cmake
		rm `python -c 'import sys; print(sys.executable[:-6])'`cmake
		CMAKE_BIN=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`/cmake/data/bin/cmake
		ln -sf ${CMAKE_BIN} /usr/local/bin/cmake
	fi
}

function pre_build {
	# Any stuff that you need to do before you start building the wheels
	# Runs in the root directory of this repository.

	# Fix cmake installation linking the appropriate binary
	fix_cmake
}


function run_tests {
	# Fix cmake installation linking the appropriate binary
	fix_cmake

        # Create source distribution and put into wheelhouse
        if [ -z "$IS_OSX" ] && [ "$MB_PYTHON_VERSION" == "3.6" ]; then
            cd ${TESTS_DIR}; python setup.py sdist --dist-dir /io/wheelhouse/;
	    echo "Created source distribution in /io/wheelhouse"
        fi

	# Runs tests on installed distribution from an empty directory
	python --version
	# python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
	cd ${TESTS_DIR}; python -m pytest -k 'not mkl_'
}
