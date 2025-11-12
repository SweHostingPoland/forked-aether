FROM alpine:latest

# Set environment variables for user and home directory
ENV USER=container
ENV HOME=/home/container

# Set the working directory
WORKDIR /home/container

# Copy the entrypoint script to the container
COPY ./entrypoint.sh /entrypoint.sh

# Update and install required packages
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        bash \
        curl \
        zip \
        unzip \
        jq \
        coreutils \
        toilet \
        wget \
        ca-certificates && \
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        lolcat \
        figlet && \
    adduser -D -h /home/container container && \
    mkdir -p /usr/share/figlet && \
    wget -P /usr/share/figlet/ https://raw.githubusercontent.com/xero/figlet-fonts/refs/heads/master/DOS%20Rebel.flf && \
    chmod +x /entrypoint.sh

# Switch to non-root user
USER container

# Set the entrypoint
CMD ["/bin/bash", "/entrypoint.sh"]