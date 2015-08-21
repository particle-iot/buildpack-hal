# Buildpack for HAL firmware

## Building image

**Before building this image, build [buildpack-arduino-preprocessor](https://github.com/suda/buildpack-arduino-preprocessor).**

```bash
$ export BUILDPACK_IMAGE=hal
$ git clone "git@github.com:suda/buildpack-${BUILDPACK_IMAGE}.git"
$ cd buildpack-$BUILDPACK_IMAGE
$ docker build -t particle/buildpack-$BUILDPACK_IMAGE .
```

## Running

```bash
$ mkdir -p ~/tmp/input && mkdir -p ~/tmp/output && mkdir -p ~/tmp/cache
$ docker run --rm \
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

**Files only available if compilation succeeded:**
* `core-firmware.bin` - compiled firmware
* `memory-use.log` - firmware memory use
