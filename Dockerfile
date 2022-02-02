FROM particle/buildpack-base:master-7604946

ARG GCC_ARM_URL
ARG GCC_ARM_CHECKSUM
ARG GCC_ARM_VERSION
ARG CMAKE_URL

RUN dpkg --add-architecture i386 \
#  && sed -i -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list \
  && apt-get update -q && apt-get install -qy \
     bzip2 \
     isomd5sum \
     jq \
     libarchive-zip-perl \
     libc6:i386 \
     make \
     vim-common \
     zip \
     wget \
     parallel \
  && curl -o /tmp/cmake_install.sh -sSL ${CMAKE_URL} \
  && chmod +x /tmp/cmake_install.sh \
  && /tmp/cmake_install.sh --skip-license --prefix=/usr/local \
  && { if [ "${GCC_ARM_VERSION}" != "manifest" ]; then \
    curl -o ./gcc-arm-none-eabi.tar.bz2 -sSL ${GCC_ARM_URL} \
    && echo "${GCC_ARM_CHECKSUM} gcc-arm-none-eabi.tar.bz2" | md5sum -c --status - \
    && mv ./gcc-arm-none-eabi.tar.bz2 /tmp/gcc-arm-none-eabi.tar.bz2 \
    && tar xjvf /tmp/gcc-arm-none-eabi.tar.bz2 -C /usr/local \
    && mv /usr/local/gcc-arm-none-eabi-*/ /usr/local/gcc-arm-embedded; \
  fi } \
  && apt-get remove -qy bzip2 \
  && apt-get clean \
  && apt-get purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/gcc-arm-embedded/share

ENV PATH /usr/local/gcc-arm-embedded/bin:$PATH
COPY bin /bin
