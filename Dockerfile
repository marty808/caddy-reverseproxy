FROM caddy:2-alpine

ENV PROXY_FROM=
ENV PROXY_TO=
ENV PROXY_CERT=INTERNAL
ENV PROXY_CA_CRT=
ENV PROXY_CFG=

COPY reverse-proxy.sh /reverse-proxy.sh
RUN chmod +x /reverse-proxy.sh
CMD /reverse-proxy.sh