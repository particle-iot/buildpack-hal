# Buildpack for HAL firmware
Buildpack for modern (HAL based) Particle firmware.

[![Build Status](https://travis-ci.org/particle-iot/buildpack-hal.svg)](https://travis-ci.org/particle-iot/buildpack-hal) [![](https://imagelayers.io/badge/particle/buildpack-hal:latest.svg)](https://imagelayers.io/?images=particle/buildpack-hal:latest 'Get your own badge on imagelayers.io')

| |
|---|
|  [Particle firmware](https://github.com/particle-iot/firmware-buildpack-builder)  |
| **HAL (you are here)** / [Legacy](https://github.com/particle-iot/buildpack-0.3.x)   |
| [Base](https://github.com/particle-iot/buildpack-base) |

This image inherits [base buildpack](https://github.com/particle-iot/buildpack-base).

## Building image

**Before building this image, build or pull [buildpack-base](https://github.com/particle-iot/buildpack-base).**

```bash
$ export BUILDPACK_IMAGE=hal
$ git clone "git@github.com:particle-iot/buildpack-${BUILDPACK_IMAGE}.git"
$ cd buildpack-$BUILDPACK_IMAGE
$ ./scripts/build-and-push
```

## Running

```bash
$ mkdir -p ~/tmp/input && mkdir -p ~/tmp/output && mkdir -p ~/tmp/cache
$ docker run --rm \
  -v ~/tmp/input:/input \
  -v ~/tmp/output:/output \
  -v ~/tmp/cache:/cache \
  -e FIRMWARE_REPO=https://github.com/particle-iot/firmware.git#v0.5.1 \
  -e PLATFORM_ID=6 \
  particle/buildpack-hal
```

### Input files
Source files have to be placed in `~/tmp/input`

### Output files
After build `~/tmp/output` will be propagated with:

* `run.log` - `stdout` combined with `stderr`
* `stderr.log` - contents of `stderr`, usefull to parse `gcc` errors

**Files only available if compilation succeeds:**
* `firmware.bin` - compiled firmware
* `memory-use.log` - firmware memory use

### ARM GCC version
When building image, couple variations will be created (you can see them by typing `docker images | grep particle/buildpack-hal`).
Most important are different [ARM GCC versions](https://launchpad.net/gcc-arm-embedded/+download) you can use.
