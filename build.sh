#!/bin/sh

# Variables
OUTPUT_DIR="bin"        # Directory to store the output binary
SOURCE_DIR="src"        # Directory containing C source files


EXECUTABLE_NAME="malloc_array_test"   # Name of the final executable
EXT=".exe"

# Compiler settings
CC=gcc                  # Compiler
CFLAGS="-Wall -Wextra"  # Compiler flags
# CFLAGS="-Wall -Wextra -Iinclude"  # Compiler flags
LDFLAGS=""              # Linker flags

SOURCES=$(find $SOURCE_DIR -name "*.c")

if [ "$1" = "lib"]; then
    SOURCE_DIR="src/lib"        # Directory containing C source files
    OUTPUT_DIR="lib"
    DLL_NAME="malloc_array"
    DLL_EXT=".dll"

    mkdir -p $OUTPUT_DIR

    echo "Compiling..."
    $CC $CFLAGS $SOURCES -shared -o $OUTPUT_DIR/$DLL_NAME$DLL_EXT -D MALLOC_ARRAY_EXPORTS

    if [ $? -ne 0 ]; then
        echo "Build failed!"
        exit 1  
    fi

    exit 0
fi

# Ensure output directory exists
mkdir -p $OUTPUT_DIR

# Find all .c files in the source directory
SOURCES=$(find $SOURCE_DIR -name "*.c")

# Compile the project
echo "Compiling..."
$CC $CFLAGS $SOURCES -o $OUTPUT_DIR/$EXECUTABLE_NAME$EXT $LDFLAGS -lmalloc_arraydll

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1  
fi

echo "Build successful! Executable: $OUTPUT_DIR/$EXECUTABLE_NAME$EXT | [R]un?"
read -r run_command
if [ "$run_command" = "r" ]; then
    ./$OUTPUT_DIR/$EXECUTABLE_NAME$EXT
fi