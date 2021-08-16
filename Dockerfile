FROM caddy:2-alpine

ENV PROXY_FROM=
ENV PROXY_TO=
ENV PROXY_CERT=INTERNAL

COPY reverse-proxy.sh /
CMD sh -f reverse-proxy.sh