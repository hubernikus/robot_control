#!/bin/bash

# Convert library code to Object file
echo "[INFO] Compiling wrapper"
gcc -o PinocchioWrapper.o -c PinocchioWrapper.cc $(pkg-config --cflags --libs pinocchio)

# Create archive file/ static library
echo "[INFO] Creating static library"
ar rcs libPinocchioWrapper.a PinocchioWrapper.o

# # Create Shared so.library
# echo "[INFO] Compiling shared (dynamic) library"
# gcc -shared -o libpinocchiowrapper.so PinocchioWrapper.o

# Create Shared so.library
echo "[INFO] Successful creation."
