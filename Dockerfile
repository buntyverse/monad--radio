FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV DISPLAY=:99

# Install OBS + dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common wget curl ffmpeg xvfb obs-studio firefox && \
    rm -rf /var/lib/apt/lists/*

# Create folders
RUN mkdir -p /config /music

# Copy pre-configured OBS config
COPY config/ /config

# Start headless OBS with stream key from env variable
CMD Xvfb :99 -screen 0 1920x1080x24 & \
    export DISPLAY=:99 && \
    obs --startstreaming \
        --scene "Main" \
        --server "${OBS_STREAM_SERVER}" \
        --key "${OBS_STREAM_KEY}"
