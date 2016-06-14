FROM particle/buildpack-base:0.3.6

ARG OAK_CORE_VERSION
# Get required packages to download the Oak libraries
RUN apt-get update && \
    apt-get -y install wget unzip python make

# Install OakCore libraries - note that this points to
# the latest "source code" zip release
RUN wget -O /oakCore.zip https://github.com/digistump/OakCore/archive/${OAK_CORE_VERSION}.zip && \
    unzip oakCore.zip && \
    mv /OakCore-${OAK_CORE_VERSION} /oakCore

# Setup tools required for building
# (Done now to speed up processing time later)
RUN cd /oakCore/tools && \
    python get.py

COPY bin /bin
COPY makefile /oakCore/makefile
