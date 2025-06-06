FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Java, Xvfb, VNC, Fluxbox, wget, unzip
RUN apt update && apt install -y \
  openjdk-17-jre xvfb fluxbox x11vnc wget unzip curl \
  && rm -rf /var/lib/apt/lists/*

# Install Burp Suite Community Edition
RUN mkdir -p /opt/burp \
  && wget "https://portswigger.net/burp/releases/download?product=community&version=2024.2.1&type=Linux" -O burp.sh \
  && chmod +x burp.sh \
  && ./burp.sh -q -dir /opt/burp \
  && rm burp.sh

# Download Jython standalone jar
RUN mkdir -p /opt/jython \
  && wget https://repo1.maven.org/maven2/org/python/jython-standalone/2.7.3/jython-standalone-2.7.3.jar -O /opt/jython/jython-standalone.jar

# Copy extension script folder
COPY extensions/ /opt/burp_extensions/

# Setup VNC password (optional)
RUN mkdir -p ~/.vnc && x11vnc -storepasswd 1234 ~/.vnc/passwd

# Startup script
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & export DISPLAY=:99 && fluxbox & x11vnc -display :99 -forever -usepw -shared & sleep 5 && /opt/burp/BurpSuiteCommunity"]

