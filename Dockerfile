FROM particle/buildpack-base:0.3.6

ARG GCC_ARM_URL
ARG GCC_ARM_VERSION
RUN dpkg --add-architecture i386 \
  && apt-get update -q && apt-get install -qy make isomd5sum bzip2 vim-common libarchive-zip-perl libc6:i386 \
  && curl -o /tmp/gcc-arm-none-eabi.tar.bz2 -sSL ${GCC_ARM_URL} \
  && tar xjvf /tmp/gcc-arm-none-eabi.tar.bz2 -C /usr/local \
  && mv /usr/local/gcc-arm-none-eabi-${GCC_ARM_VERSION}/ /usr/local/gcc-arm-embedded \
  && apt-get remove -qy bzip2 && apt-get clean && apt-get purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/gcc-arm-embedded/share

ENV PATH /usr/local/gcc-arm-embedded/bin:$PATH
COPY bin /bin
