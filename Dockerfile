FROM particle/buildpack-base:0.3.6
MAINTAINER Digistump LLC <support@digistump.com> 

ARG OAK_CORE_VERSION
# Get required packages to download the Oak libraries
RUN apt-get update && \
    apt-get -y install wget unzip python make && \
    apt-get clean

# Install OakCore libraries - note that this points to
# the latest "source code" zip release
RUN wget -O /oakCore.zip https://github.com/digistump/OakCore/archive/${OAK_CORE_VERSION}.zip && \
    unzip oakCore.zip && \
    mv /OakCore-${OAK_CORE_VERSION} /oakCore

# Place supporting files into the right places
COPY bin /bin
RUN cp /oakCore/variants/oak/pins_arduino.* /oakCore/cores/oak/

# Run some setup scripts now to make subsequent processing a lot faster

# Setup tools required for building 
RUN cd /oakCore/tools && \
    python get.py

# Build pre-requsities
COPY makefile /oakCore/makefile
RUN cd /oakCore && \
    . /bin/setup-env && \
    make
