FROM ubuntu:16.04 as issue21-check

# Prepare build environment
RUN apt-get update && \
	apt-get -qq -y install apt-utils && \
	apt-get -qq -y install gcc g++ libtool git make

RUN apt-get -qq -y install wget

WORKDIR /root

ARG cmake_ver=3.13
ARG cmake_build=3
ARG cmake_full_name=cmake-${cmake_ver}.${cmake_build}
RUN mkdir tmp && \
	cd tmp && \
	wget https://cmake.org/files/v${cmake_ver}/${cmake_full_name}.tar.gz && \
	tar -xzvf ${cmake_full_name}.tar.gz && \
	cd ${cmake_full_name} && \
	./bootstrap && \
	make -j4 && \
	make install && \
	cmake --version && \
	cd ..

RUN apt-get -qq -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get -qq -y install gcc-7 g++-7

RUN apt-get -qq -y install clang clang-6.0

RUN \
	update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-6.0/bin/clang 50 && \
	update-alternatives --install /usr/bin/clang++ clang++  /usr/lib/llvm-6.0/bin/clang++ 50

RUN update-alternatives --set cc /usr/bin/clang && \
	update-alternatives --set c++ /usr/bin/clang++

RUN mkdir issue21 && \
	mkdir issue21/deps && \
	mkdir issue21/src

RUN cd tmp && \
	git clone https://github.com/eao197/so-5-5 && \
	cd so-5-5 && \
	mkdir cmake_build && cd cmake_build && \
	cmake -DCMAKE_INSTALL_PREFIX=/root/issue21/deps \
			-DCMAKE_BUILD_TYPE=Release \
			-DSOBJECTIZER_BUILD_STATIC=OFF \
			-DSOBJECTIZER_BUILD_SHARED=ON \
			../dev && \
	cmake --build . --config Release --target install && \
	cd /root

COPY src issue21/src

# RUN apt-get -qq -y install vim

RUN cd issue21/src && mkdir cmake_build && cd cmake_build && \
	cmake -DCMAKE_BUILD_TYPE=Release .. && \
	cmake --build . --config Release 

