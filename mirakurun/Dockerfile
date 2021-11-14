ARG ARCH=
FROM ${ARCH}node:16.6.1-buster AS build
WORKDIR /app
ENV DOCKER=YES
ADD mirakurun/ .
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends build-essential && \
    npm install && \
    npm run build && \
    npm install -g --unsafe-perm --production

FROM ${ARCH}node:16.6.1-buster-slim

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
        dvb-tools \
        && \
    apt-get install -y $DEV && \
    \
    git clone https://github.com/stz2012/libarib25.git /tmp/libarib25 && \
    cd /tmp/libarib25 && \
    cmake . && \
    make && \
    make install && \
    rm -rf /tmp/libarib25 && \
    \
    git clone https://github.com/stz2012/recpt1 /tmp/recpt1 && \
    cd /tmp/recpt1/recpt1 && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
    rm -rf /tmp/recpt1 && \
    \
    git clone https://github.com/dogeel/recdvb.git /tmp/recdvb && \
    cd /tmp/recdvb && \
    ./autogen.sh && \
    ./configure --enable-b25 && \
    make && \
    make install && \
    rm -rf /tmp/recdvb && \
    \
    apt-get -y remove $DEV && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local/lib/node_modules/mirakurun /app
CMD ["./docker/container-init.sh"]
EXPOSE 40772 9229
