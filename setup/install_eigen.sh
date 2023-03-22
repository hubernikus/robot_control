#!/bin/bash
SCRIPT=$(readlink -f "${BASH_SOURCE[0]}")
SOURCE_PATH=$(dirname "$SCRIPT")

EIGEN_VERSION=3.4.0
PINOCCHIO_TAG=2.6.9

echo ">>> INSTALLING pkg-config tool"
apt-get update && apt-get install "${AUTO_INSTALL}" pkg-config

echo ">>> INSTALLING EIGEN"
mkdir -p "${SOURCE_PATH}"/tmp/lib && cd "${SOURCE_PATH}"/tmp/lib
wget -c "https://gitlab.com/libeigen/eigen/-/archive/${EIGEN_VERSION}/eigen-${EIGEN_VERSION}.tar.gz" -O - | tar -xz 
cd "eigen-${EIGEN_VERSION}" && mkdir -p build && cd build && env CXXFLAGS=-DEIGEN_MPL2_ONLY cmake .. && make install

EIGEN_PATH=$(cmake --find-package -DNAME=Eigen3 -DCOMPILER_ID=GNU -DLANGUAGE=C -DMODE=COMPILE)
if [ "${EIGEN_PATH::14}" != "-I/usr/include" ]; then
	rm -rf /usr/include/eigen3 && ln -s ${EIGEN_PATH:2} /usr/include/eigen3
fi

echo ">>> INSTALLING ROBOT MODEL DEPENDENCIES"
apt-get update && apt-get install "${AUTO_INSTALL}" libboost-all-dev liburdfdom-dev

pkg-config pinocchio --atleast-version=${PINOCCHIO_TAG}
if [ "$?" != 0 ]; then
  echo ">>> INSTALLING PINOCCHIO"
  git clone --depth 1 -b v${PINOCCHIO_TAG} --recursive https://github.com/stack-of-tasks/pinocchio \
      && cd pinocchio && mkdir build && cd build \
      && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_PYTHON_INTERFACE=OFF \
      && make -j1 && make install && cd ../.. && rm -r pinocchio
fi

ldconfig

# Cleanum and reset
rm -rf "${SOURCE_PATH}"/tmp
cd "${SOURCE_PATH}" || return
