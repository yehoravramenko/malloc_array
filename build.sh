#!/bin/sh

# Variables
OUTPUT_DIR="bin"        # Directory to store the output binary
SOURCE_DIR="src"        # Directory containing C source files

EXECUTABLE_NAME="malloc_array_test"   # Name of the final executable
EXT=".exe"

# Compiler settings
CC=gcc                  # Compiler
CFLAGS="-Wall -Wextra -g"  # Compiler flags
LDFLAGS="-L./bin"              # Linker flags


if [ "$1" = "lib" ]; then
    SOURCE_DIR="lib"        # Directory containing C source files
    DLL_NAME="malloc_array"
    DLL_EXT=".dll"
    SOURCES=$(find $SOURCE_DIR -name "*.c")
    mkdir -p $OUTPUT_DIR
    echo "Compiling..."
    if [ "$2" = "debug" ]; then
        $CC $CFLAGS $SOURCES -shared -Os -s -o $OUTPUT_DIR/$DLL_NAME$DLL_EXT -D DEBUG
    else
        $CC $CFLAGS $SOURCES -shared -Os -s -o $OUTPUT_DIR/$DLL_NAME$DLL_EXT
    fi
    if [ $? -ne 0 ]; then
        echo "Build failed!"
        exit 1  
    fi
    echo "Build successful!"
    exit 0
fi

# Ensure output directory exists
mkdir -p $OUTPUT_DIR

# Find all .c files in the source directory
SOURCES=$(find $SOURCE_DIR -name "*.c")

# Compile the project
echo "Compiling..."
$CC $CFLAGS $SOURCES -o $OUTPUT_DIR/$EXECUTABLE_NAME$EXT $LDFLAGS -lmalloc_array

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1  
fi

echo "Build successful! Executable: $OUTPUT_DIR/$EXECUTABLE_NAME$EXT | [R]un?"
read -r run_command
if [ "$run_command" = "r" ]; then
    exec ./$OUTPUT_DIR/$EXECUTABLE_NAME$EXT
fi