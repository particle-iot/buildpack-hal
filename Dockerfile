FROM particle/buildpack-base:0.5.0

ARG CMAKE_URL

RUN apt-get update -q && apt-get install -qy \
     isomd5sum \
     jq \
     libarchive-zip-perl \
     make \
     vim-common \
     zip \
     wget \
     parallel \
     gnupg \
  && curl -o /tmp/cmake_install.sh -sSL ${CMAKE_URL} \
  && chmod +x /tmp/cmake_install.sh \
  && /tmp/cmake_install.sh --skip-license --prefix=/usr/local \
  && apt-get clean \
  && apt-get purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY bin /bin
