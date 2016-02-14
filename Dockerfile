FROM particle/buildpack-wiring-preprocessor:0.0.3

# Install PlatformIO
RUN apt-get update
RUN apt-get -y install python-pip wget unzip

RUN pip install -U platformio

# Install OakCore libraries
RUN wget -O oakCore.zip https://github.com/digistump/OakCore/archive/0.9.3.zip && \
    unzip oakCore.zip

# Setup PlatformIO

COPY hooks /hooks
