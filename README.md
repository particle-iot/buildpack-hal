# Buildpack for HAL firmware
Buildpack for modern (HAL based) Particle firmware.

[![Build Status](https://travis-ci.org/spark/buildpack-hal.svg)](https://travis-ci.org/spark/buildpack-hal)

| |
|---|
|  [Particle firmware](https://github.com/spark/firmware-buildpack-builder)  |
| **HAL (you are here)** / [Legacy](https://github.com/spark/buildpack-0.3.x)   |
| [Wiring preprocessor](https://github.com/spark/buildpack-wiring-preprocessor) |
| [Base](https://github.com/spark/buildpack-base) |

This image inherits [Wiring preprocessor](https://github.com/spark/buildpack-wiring-preprocessor) and calls [`preprocess-ino` function](https://github.com/spark/buildpack-wiring-preprocessor#running) before doing build.

## Building image

**Before building this image, build or pull [buildpack-wiring-preprocessor](https://github.com/spark/buildpack-wiring-preprocessor).**

```bash
$ export BUILDPACK_IMAGE=hal
$ git clone "git@github.com:spark/buildpack-${BUILDPACK_IMAGE}.git"
$ cd buildpack-$BUILDPACK_IMAGE
$ docker build -t particle/buildpack-$BUILDPACK_IMAGE .
```

## Running

```bash
$ mkdir -p ~/tmp/input && mkdir -p ~/tmp/output && mkdir -p ~/tmp/cache
$ docker run --rm=false \
  --privileged \
  -v ~/tmp/input:/input \
  -v ~/tmp/output:/output \
  -v ~/tmp/cache:/cache \
  -e FIRMWARE_REPO=https://github.com/spark/firmware.git#photon_043 \
  -e PLATFORM_ID=6
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
