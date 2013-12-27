#! /bin/sh
. ./test/helper.sh

DEFAULT_EXPORT_FLAG="-exportPackage"
DEFAULT_EXPORT_PATH="TexturePacker"
DEFAULT_EXPORT_DST="Assets/TexturePacker"
DEFAULT_OUTPUT="TexturePackerImporter.unitypackage"

EXPECTED_CREATE_PROJECT="/Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode -createProject .;"
EXPECTED_COPY_CONTENTS="cp -r TexturePacker Assets/TexturePacker;"

oneTimeTearDown()
{
  rm ./results.txt
}

testScriptShouldOutputExpectedUnknown()
{	
	EXPECTED='Expected output differs.'
	./pack_unity_package -b > ./results.txt
	diff ./test/expected_unknown.txt ./results.txt
	assertTrue "${EXPECTED}" $?
}

testHFlagShouldOutputHelp()
{	
	EXPECTED='Expected output differs.'
	./pack_unity_package -h > ./results.txt
	diff ./test/expected_help.txt ./results.txt
	assertTrue "${EXPECTED}" $?
}

testScriptShouldOutputExpectedVersion()
{
	EXPECTED="pack_unity_package version 1.0"
	./pack_unity_package -d -v > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
}

testScriptShouldWarnIfUnityIsMissing()
{
	EXPECTED="Unity path is incorrect or missing."
	./pack_unity_package -d -u "/fake" > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
}

testScriptShouldOutputCmdOnDryRunFlag()
{
	EXPECTED="$EXPECTED_CREATE_PROJECT$EXPECTED_COPY_CONTENTS/Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode ${DEFAULT_EXPORT_FLAG} ${DEFAULT_EXPORT_DST} ${DEFAULT_OUTPUT};"
	./pack_unity_package -d > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
}

testScriptShouldWarnIfFolderIsMissing()
{
	EXPECTED="Folder path is incorrect or missing."
	./pack_unity_package -d -f "/fake" > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
}

testScriptShouldUseCorrectFolderWhenFFlagIsSet()
{
	mkdir "fake"
	EXPECTED_FILE="fake"
	EXPECTED_ASSETS_PATH=Assets/${EXPECTED_FILE}
	EXPECTED_COPY="cp -r ${EXPECTED_FILE} ${EXPECTED_ASSETS_PATH};"
	EXPECTED="$EXPECTED_CREATE_PROJECT$EXPECTED_COPY/Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode ${DEFAULT_EXPORT_FLAG} ${EXPECTED_ASSETS_PATH} ${DEFAULT_OUTPUT};"
	./pack_unity_package -d -f "${EXPECTED_FILE}" > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
	rmdir "fake"
}

testScriptShouldUseCorrectUnityFlagWhenFFlagIsSet()
{
	mkdir "fake"
	EXPECTED_FILE="fake"
	EXPECTED_ASSETS_PATH=Assets/${EXPECTED_FILE}
	EXPECTED_COPY="cp -r ${EXPECTED_FILE} ${EXPECTED_ASSETS_PATH};"
	EXPECTED_COMMAND="exportPackage"
	EXPECTED="$EXPECTED_CREATE_PROJECT$EXPECTED_COPY/Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode -${EXPECTED_COMMAND} ${EXPECTED_ASSETS_PATH} ${DEFAULT_OUTPUT};"
	./pack_unity_package -d -f "${EXPECTED_FILE}" > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
	rmdir "fake"
}

testScriptShouldUseCorrectOutputPathWhenOFlagIsSet()
{
	EXPECTED_PATH="expectedOutputPath"
	EXPECTED="$EXPECTED_CREATE_PROJECT$EXPECTED_COPY_CONTENTS/Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode ${DEFAULT_EXPORT_FLAG} ${DEFAULT_EXPORT_DST} ${EXPECTED_PATH};"
	./pack_unity_package -d -o "${EXPECTED_PATH}" > ./results.txt
	firstline=`head -1 ./results.txt`
	assertEquals "${EXPECTED}" "${firstline}"
}

# run shunit2
SHUNIT_PARENT=$0 . $SHUNIT2