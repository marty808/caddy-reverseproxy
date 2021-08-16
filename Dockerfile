FROM caddy:2-alpine

ENV PROXY_FROM=
ENV PROXY_TO=
ENV PROXY_CERT=INTERNAL

COPY reverse-proxy.sh /reverse-proxy.sh
RUN chmod +x /reverse-proxy.sh
CMD ./reverse-proxy.sh