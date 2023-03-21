#!/bin/bash

# Convert library code to Object file
g++ -o PinocchioWrapper.o -c PinocchioWrapper.cc $(pkg-config --cflags --libs pinocchio)

# Create archive file/ static library
ar rcs PinocchioWrapper.a PinocchioWrapper.o
