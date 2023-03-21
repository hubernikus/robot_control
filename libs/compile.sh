#!/bin/bash
g++ -o PinocchioWrapper.o -c PinocchioWrapper.cc -o overview-simple $(pkg-config --cflags --libs pinocchio) PinocchioWrapper.a
