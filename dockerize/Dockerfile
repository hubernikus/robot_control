FROM ubuntu:22.04

# INSTALL NECESSARY PACKAGES
USER root
ENV HOME ros2

RUN apt-get update
RUN	apt-get install --no-install-recommends -y \
	autoconf \
	automake \
	curl \
	featherpad \
	gdb \
	git \
	iputils-ping \
	libboost-all-dev \
	libtool \ 
	mesa-utils \
	nano \	
	neovim\
	python3-pip \
	# ros-${ROS_DISTRO}-rviz2 \
	rsync \
	software-properties-common \
	ssh \
	unzip \
	wget

# RUN rm -rf /var/lib/apt/lists/*
RUN mkdir ${HOME}/tmp
WORKDIR ${HOME}/tmp
COPY setup/install_eigen.sh install.sh
RUN ./install.sh
RUN rm install.sh

# Compile PinocchioWrapper
WORKDIR ${HOME}
COPY libs libs
COPY src src

# Compile cargo
RUN bash libs/compile.sh

