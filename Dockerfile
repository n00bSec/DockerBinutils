#Start from an ubuntu base image.
FROM ubuntu:17.10

RUN apt update && apt install -y build-essential tmux file texinfo libc6-dev autoconf

#Add current directory into /fuzz in the app.
ADD afl-latest.tgz binutils-2.30.tar.xz /fuzz

#Compile AFL
WORKDIR /fuzz
RUN tar xzvf afl-latest.tgz
WORKDIR /fuzz/afl-2.52b
RUN make


#Compile binutils
WORKDIR /fuzz
RUN tar xvf binutils-2.30.tar.xz
WORKDIR /fuzz/binutils-2.30
RUN CC=/fuzz/afl-2.52b/afl-gcc CXX=/fuzz/afl-2.52b/afl-g++ AFL_USE_ASAN=1 LDFLAGS="-ldl" ./configure
RUN AFL_USE_ASAN=1 make clean all

#Finalize Setup
WORKDIR /fuzz
