# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
RUN set -xe \
    && apk add --no-cache --purge -uU \
        transmission-cli \
        transmission-daemon \
        tzdata \
    && rm -rf /var/cache/apk/* /tmp/*
    # /var/lib/transmission/config/*
#
COPY root/ /
#
VOLUME /var/lib/transmission/config/ /var/lib/transmission/downloads/ /var/lib/transmission/incomplete/ /var/lib/transmission/torrents/
#
EXPOSE 9091 52437 52437/udp
#
HEALTHCHECK \
    --interval=2m \
    --retries=5 \
    --start-period=5m \
    --timeout=10s \
    CMD \
    wget --quiet --tries=1 --no-check-certificate --spider ${HEALTHCHECK_URL:-"http://localhost:9091/transmission/"} || exit 1
#
ENTRYPOINT ["/init"]
