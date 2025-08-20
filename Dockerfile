FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV DISPLAY=:99

# Install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common wget curl ffmpeg xvfb x11vnc fluxbox obs-studio firefox && \
    rm -rf /var/lib/apt/lists/*

# Create folders
RUN mkdir -p /config /music

# Set up x11vnc password (non-interactive)
RUN x11vnc -storepasswd yourpassword /config/passwd

# Expose VNC port (optional)
EXPOSE 5900

# Start Xvfb, x11vnc, fluxbox, and OBS automatically
CMD Xvfb :99 -screen 0 1920x1080x24 & \
    x11vnc -rfbport 5900 -forever -passwdfile /config/passwd & \
    fluxbox & \
    obs --startstreaming --scene "Main"
