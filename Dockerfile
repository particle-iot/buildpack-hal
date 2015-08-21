FROM particle/buildpack-arduino-preprocessor

RUN apt-get -y install make isomd5sum vim-common libarchive-zip-perl
RUN apt-get -y install gcc-arm-none-eabi

COPY hooks /hooks
