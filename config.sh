# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
	# Any stuff that you need to do before you start building the wheels
	# Runs in the root directory of this repository.

	# Fix cmake installation linking the appropriate binary
	rm `python -c 'import sys; print(sys.executable[:-6])'`/cmake
	CMAKE_BIN=`python -c "import site; print(site.getsitepackages()[0])"`/cmake/data/bin/cmake
	ln -sf ${CMAKE_BIN} /usr/bin/cmake
}


function run_tests {

	# Runs tests on installed distribution from an empty directory
	python --version
	# python -c 'import sys; import yourpackage; sys.exit(yourpackage.test())'
	cd ${TESTS_DIR}; python -m pytest -k 'not mkl_'
}
