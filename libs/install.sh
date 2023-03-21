#!/bin/bash
SCRIPT=$(readlink -f "${BASH_SOURCE[0]}")
SOURCE_PATH=$(dirname "$SCRIPT")

BUILD_ROBOT_MODEL="ON"

EIGEN_VERSION=3.4.0
OSQP_TAG=0.6.2
OSQP_EIGEN_TAG=0.6.4
PINOCCHIO_TAG=2.6.9

# cleanup any previous build folders
rm -rf "${SOURCE_PATH}"/tmp

# install base dependencies
echo ">>> INSTALLING BASE DEPENDENCIES"

if [ -z $(which pkg-config) ]; then
	echo ">>> INSTALLING pkg-config tool"
	apt-get update && apt-get install "${AUTO_INSTALL}" pkg-config || exit 1
fi

pkg-config eigen3 --atleast-version="${EIGEN_VERSION}"
if [ "$?" != 0 ]; then
	echo ">>> INSTALLING EIGEN"
	mkdir -p "${SOURCE_PATH}"/tmp/lib && cd "${SOURCE_PATH}"/tmp/lib || exit 1
	wget -c "https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_VERSION}/eigen-${EIGEN_VERSION}.tar.gz" -O - | tar -xz || exit 1
	cd "eigen-${EIGEN_VERSION}" && mkdir -p build && cd build && env CXXFLAGS=-DEIGEN_MPL2_ONLY cmake .. && make install || exit 1
fi
EIGEN_PATH=$(cmake --find-package -DNAME=Eigen3 -DCOMPILER_ID=GNU -DLANGUAGE=C -DMODE=COMPILE)
if [ "${EIGEN_PATH::14}" != "-I/usr/include" ]; then
	rm -rf /usr/include/eigen3 && ln -s ${EIGEN_PATH:2} /usr/include/eigen3 || exit 1
fi

# install module-specific dependencies
if [ "${BUILD_ROBOT_MODEL}" == "ON" ]; then
  echo ">>> INSTALLING ROBOT MODEL DEPENDENCIES"
  apt-get update && apt-get install "${AUTO_INSTALL}" libboost-all-dev liburdfdom-dev || exit 1

  pkg-config pinocchio --atleast-version=${PINOCCHIO_TAG}
  if [ "$?" != 0 ]; then
    mkdir -p "${SOURCE_PATH}"/tmp/lib && cd "${SOURCE_PATH}"/tmp/lib || exit 1

    echo ">>> INSTALLING OSQP [1/3]"
    git clone --depth 1 -b v${OSQP_TAG} --recursive https://github.com/oxfordcontrol/osqp \
        && cd osqp && mkdir build && cd build && cmake -G "Unix Makefiles" .. && cmake --build . --target install \
        && cd ../.. && rm -r osqp || exit 1

    echo ">>> INSTALLING OSQP_EIGEN [2/3]"
    git clone --depth 1 -b v${OSQP_EIGEN_TAG} https://github.com/robotology/osqp-eigen.git \
        && cd osqp-eigen && mkdir build && cd build && cmake .. && make -j && make install \
        && cd ../.. && rm -r osqp-eigen || exit 1

    echo ">>> INSTALLING PINOCCHIO [3/3]"
    git clone --depth 1 -b v${PINOCCHIO_TAG} --recursive https://github.com/stack-of-tasks/pinocchio \
        && cd pinocchio && mkdir build && cd build \
        && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_PYTHON_INTERFACE=OFF \
        && make -j1 && make install && cd ../.. && rm -r pinocchio || exit 1
  fi
  ldconfig
fi

# cleanup any temporary folders
rm -rf "${SOURCE_PATH}"/tmp

# reset location
cd "${SOURCE_PATH}" || return


