ARG DEBIAN_FRONTEND=noninteractive

###############
# Working image
FROM node:8-slim as worker

# Pull in temporary build environment variables
ARG DEBIAN_FRONTEND
ARG NPM_TOKEN
ARG PARTICLE_DEVICEOS_VERSION=1.4.0
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# Copy GitHub credentials
COPY ./.netrc /root/

# Install build dependencies
RUN ["bash", "-c", "\
    apt-get update \
 && apt-get install -y --no-install-recommends \
      git \
 && rm -rf /var/lib/apt/lists/* \
"]

# Setup Node environment
RUN ["dash", "-c", "\
    npm install -g npm@5 \
"]

# Clone Workbench source from GitHub
RUN ["dash", "-c", "\
    mkdir /particle-iot \
 && cd /particle-iot \
 && git clone https://github.com/particle-iot/workbench.git --recursive \
 && chown --recursive node:node /particle-iot/workbench/ \
"]

# Install Workbench dependencies
USER node
WORKDIR /particle-iot/workbench/
RUN ["dash", "-c", "\
    npm config set //registry.npmjs.org/:_authToken=${NPM_TOKEN} \
 && npm i --ignore-scripts \
 && cd ./packages/particle-vscode-core/ \
 && npm i --ignore-scripts \
"]

# Install toolchain dependencies
RUN ["dash", "-c", "\
    node /particle-iot/workbench/bin/installtoolchain.js ${PARTICLE_DEVICEOS_VERSION} \
"]

ENTRYPOINT ["sh"]

#####################
# Buildpack HAL image
FROM particle/buildpack-base:0.3.8 as buildpack-hal

COPY --from=worker /home/node/.particle/toolchains/gcc-arm/5.3.1 /usr/local/gcc-arm-embedded

RUN dpkg --add-architecture i386 \
 && apt-get update -q && apt-get install -qy \
      jq \
# `libarchive-zip-perl` satisfies `crc32` dependency
      libarchive-zip-perl \
      libc6:i386 \
      make \
# `vim-common` satisfies `xxd` dependency
      vim-common \
      zip \
 && apt-get clean \
 && apt-get purge \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH /usr/local/gcc-arm-embedded/bin:$PATH
COPY bin /bin
