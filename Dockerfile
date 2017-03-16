FROM ubuntu:16.10

RUN apt update && \
  apt install -y \
  git clang-3.9 cmake

RUN git clone https://github.com/llvm-mirror/llvm && \
  cd llvm/tools && \
  git clone https://github.com/llvm-mirror/clang

ADD build.sh /llvm
RUN cd /llvm && ./build.sh
