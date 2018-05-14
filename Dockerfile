#Start from an ubuntu base image.
FROM ubuntu:17.10

RUN apt update && apt install -y build-essential tmux file texinfo libc6-dev autoconf

#Just for personal convenience
RUN apt install -y vim

#Add current directory into /fuzz in the app.
ADD . /fuzz/

#Compile AFL
WORKDIR /fuzz/
RUN tar xzvf afl-latest.tgz
WORKDIR /fuzz/afl-2.52b
RUN make


#Compile binutils
WORKDIR /fuzz/
RUN tar xvf binutils-2.30.tar.xz
WORKDIR /fuzz/binutils-2.30
RUN CC=/fuzz/afl-2.52b/afl-gcc CXX=/fuzz/afl-2.52b/afl-g++ LDFLAGS="-ldl" ./configure
RUN make clean all

#Finalize Setup
WORKDIR /fuzz/
CMD ["/fuzz/startfuzz.sh"]
