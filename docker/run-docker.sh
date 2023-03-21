#!/bin/bash
docker run \
	   -it \
	   -e DISPLAY=$DISPLAY \
	   -h $HOSTNAME \
	   -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -v $HOME/.Xauthority:/home/ros2/.Xauthority \
	   --net host \
	   -v "$(pwd)"/../libs/:/home/ros2/libs:rw \
	   -v "$(pwd)"/../libs/:/home/ros2/libs:rw \
	   robot_control
