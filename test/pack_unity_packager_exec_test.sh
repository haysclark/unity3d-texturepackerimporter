#! /bin/sh
. ./test/helper.sh

testExecNoArguments()
{
	./pack_unity_package -d 2>/dev/null
	assertEquals "did not exit with 0" 0 $?
}

# run shunit2
SHUNIT_PARENT=$0 . $SHUNIT2