FROM particle/buildpack-wiring-preprocessor:0.0.3

# Get required packages to download the Oak libraries
RUN apt-get update && \
    apt-get -y install wget unzip

# Install OakCore libraries - note that this points to 
# the latest "source code" zip release
RUN wget -O /oakCore.zip https://github.com/digistump/OakCore/archive/0.9.4.zip && \
    unzip oakCore.zip && \
    mv /OakCore-0.9.4 /oakCore 

# Setup tools required for building
# (Done now to speed up processing time later)
RUN cd /oakCore/tools && \
    python get.py

COPY hooks /hooks
COPY makefile /oakCore/makefile
