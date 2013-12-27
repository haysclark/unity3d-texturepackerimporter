SHUNIT2=/usr/bin/shunit2

export PREFIX="$PWD/test"
export PATH="$PWD/bin:$PATH"

test_path="$PATH"

setUp() { return; }
tearDown() { return; }
oneTimeTearDown() { return; }