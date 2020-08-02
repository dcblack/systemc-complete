# Regression tests for SystemC-Complete

This directory contains test cases for the SystemC-Complete project. They are run by the `regress` script.

All tests are self-contained in their own directory. The `regress` script visits each directory and attempts to validate it.

A `README.md` file shall exist in every directory to explain the test.

There are three items used to control these tests, but only any one is needed:

1. A script named run.sh can exist to direct how the test proceeds. If this script is missing, `regress` assumes a simple `scc compile` will do the job.
2. A script named validate.sh can exist to verify that everything went well. Its exit status will be used to determine success of failure.
3. If a `run.golden` file exists, it will be compared via diff with the build/log.dir/run.log file for equality. If there are no differences, success is assumed.

After running a test, `regress`  will use `scc clean --everything` to remove all generated files and directories.

Running `regress` with the `-dev` option suppresses clean up.
