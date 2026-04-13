FROM node:20-bookworm AS build
ARG MIRAKURUN_VERSION=4.0.0-beta.18
WORKDIR /app
ENV DOCKER=YES
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git ca-certificates build-essential && \
    git clone --depth 1 --branch ${MIRAKURUN_VERSION} \
        https://github.com/Chinachu/Mirakurun.git . && \
    npm install && \
    npm run build && \
    npm install -g --unsafe-perm --production

FROM node:20-bookworm-slim

WORKDIR /app
ENV DEV="build-essential libtool autoconf git automake cmake"
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        make \
        gcc \
        g++ \
        pkg-config \
        pcscd \
        libpcsclite-dev \
        libccid \
        libdvbv5-dev \
        pcsc-tools \
        v4l-utils \
        && \
    apt-get install -y $DEV && \
    \
    git clone https://github.com/stz2012/libarib25.git /tmp/libarib25 && \
    cd /tmp/libarib25 && \
    cmake . && \
    make && \
    make install && \
    \
    git clone https://github.com/stz2012/recpt1 /tmp/recpt1 && \
    cd /tmp/recpt1/recpt1 && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
    \
    git clone https://github.com/dogeel/recdvb.git /tmp/recdvb && \
    cd /tmp/recdvb && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
    \
    apt-get -y remove $DEV && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/libarib25 && \
    rm -rf /tmp/recpt1 && \
    rm -rf /tmp/recdvb
COPY --from=build /usr/local/lib/node_modules/mirakurun /app
CMD ["./docker/container-init.sh"]
EXPOSE 40772 9229
