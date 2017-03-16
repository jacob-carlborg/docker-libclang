#!/bin/bash

set -e

versions=(40 39)

for version in "${versions[@]}"; do
  git checkout origin/release_$version

  pushd tools/clang
  git checkout origin/release_$version
  popd

  mkdir build
  pushd build
  CC=clang-3.9 CXX=clang++-3.9 cmake .. \
    -DLIBCLANG_BUILD_STATIC=On \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local/llvm-$version

  make -j 4
  cmake --build . --target install
  cp lib/libclang.a /usr/local/llvm-$version/lib
  popd
  rm -rf build
done
