#!/usr/bin/env bash

# change to script directory
cd "${0%/*}"

# create ../bin directory if not exists
if [ ! -d "../bin" ]
then
    mkdir ../bin
fi

# compile the code into the bin folder
javac  ../src/seedu/addressbook/AddressBook.java -d ../bin

# (invalid) no parent directory, invalid filename with no extension
java -classpath ../bin seedu.addressbook.AddressBook ' ' < /dev/null > actual2.txt
# (invalid) invalid parent directory that does not exist, valid filename
java -classpath ../bin seedu.addressbook.AddressBook 'directoryThatDoesNotExist/valid.filename' < /dev/null >> actual2.txt
# (invalid) no parent directory, invalid filename with dot on first character
java -classpath ../bin seedu.addressbook.AddressBook '.noFilename' < /dev/null >> actual2.txt
# (invalid) valid parent directory, non regular file
mkdir -p data/notRegularFile.txt
java -classpath ../bin seedu.addressbook.AddressBook 'data/notRegularFile.txt' < /dev/null >> actual2.txt
# (valid) valid parent directory, valid filename with extension.
touch data/valid.filename
java -classpath ../bin seedu.addressbook.AddressBook 'data/valid.filename' < exitinput.txt >> actual2.txt
# run the program, feed commands from input.txt file and redirect the output to the actual.txt
java -classpath ../bin seedu.addressbook.AddressBook < input.txt >> actual2.txt

# compare the output to the expected output
diff actual2.txt expected2.txt
if [ $? -eq 0 ]
then
    echo "Test result: PASSED"
else
    echo "Test result: FAILED"
fi
