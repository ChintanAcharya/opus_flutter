FROM ubuntu:bionic

# Install dependencies
RUN apt-get update \
	&& DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
	apt-transport-https \
	wget \
	gnupg \
	ca-certificates \
	git \
	autoconf \
	automake \
	libtool \
	gcc \
	make \
	mingw-w64

# Clone opus
WORKDIR /app
RUN git clone --branch v1.3.1 https://github.com/xiph/opus.git
WORKDIR /app/opus

# Build opus using MacOS cross compile
RUN ./autogen.sh \
	&& ./configure --host=arm-apple-darwin --disable-extra-programs --disable-doc --enable-shared \
	&& make \
	&& mv ./.libs/libopus.0.dylib /app/libopus_arm.dylib.blob \
	&& make clean \

RUN ./configure --host=x86_64-apple-darwin --disable-extra-programs --disable-doc --enable-shared \
	&& make \
	&& mv ./.libs/libopus.0.dylib /app/libopus_x86_64.dylib.blob \
	&& make clean
WORKDIR /app