#!/bin/bash

export BUILD_ARCH=x86-64

mkdir build

cd build

cmake .. \
      -DCOMPILE_CUDA=off \
      -DBUILD_ARCH=${BUILD_ARCH} \
      -DCMAKE_BUILD_TYPE=Release \
      -DUSE_STATIC_LIBS=on \
      -DUSE_SENTENCEPIECE=on \
      -DCOMPILE_SERVER=on \
      -DCOMPILE_EXAMPLES=on

make -j1
