FROM linuxserver/qbittorrent

USER root

RUN apk update

RUN apk add ca-certificates coreutils tzdata

RUN echo '@testing http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        java-cacerts \
        java-jna \
        libzen@testing \
        libmediainfo@testing \
        openjdk8-jre-base

ARG PUID
ARG PGID
ENV PUID $PUID
ENV PGID $PGID


# Install filebot
WORKDIR /usr/local/bin
COPY FileBot_4.7.7-portable.tar.xz filebot.tar.xz
RUN ls -lah
RUN tar xvf filebot.tar.xz
RUN chmod +x filebot.sh
RUN mv filebot.sh filebot
RUN chown -R ${PUID}:${PGID} /usr/local/bin
# RUN filebot --help

# RUN filebot -script fn:sysinfo
