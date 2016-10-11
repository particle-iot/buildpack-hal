# Buildpack for Oak devices
Buildpack for Oak devices using Particle.

[![Build Status](https://travis-ci.org/digistump/buildpack-oak.svg)](https://travis-ci.org/digistump/buildpack-oak)

| |
|---|
| **Oak (you are here)**    |
| [Base](https://github.com/spark/buildpack-base) |

This image inherits [base buildpack](https://github.com/spark/buildpack-base).

## Building image

**Before building this image, build or pull [buildpack-base](https://github.com/spark/buildpack-base).**

```bash
$ export BUILDPACK_IMAGE=oak
$ git clone "git@github.com:digistump/buildpack-${BUILDPACK_IMAGE}.git"
$ cd buildpack-$BUILDPACK_IMAGE
$ docker build -t digistump/buildpack-$BUILDPACK_IMAGE .
```

## Running

```bash
$ mkdir -p ~/tmp/input && mkdir -p ~/tmp/output && mkdir -p ~/tmp/cache
$ docker run --rm \
  -v ~/tmp/input:/input \
  -v ~/tmp/output:/output \
  -v ~/tmp/cache:/cache \
  -v ~/tmp/log:/log \
  digistump/buildpack-oak
```

### Input files
Source files have to be placed in `~/tmp/input`

### Output files
If compilation succeeds `~/tmp/output` will be propagated with:

* `firmware.bin` - compiled firmware

### Log files
Following logs will be placed in `~/tmp/log`:

* `run.log` - `stdout` combined with `stderr`
* `stderr.log` - contents of `stderr`, usefull to parse `gcc` errors
