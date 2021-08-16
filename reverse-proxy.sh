#!/bin/sh

# check for environment variables
if [ -z $PROXY_FROM ]; then
   echo "PROXY_FROM is empty"
   exit 2
fi

if [ -z $PROXY_TO ]; then
   echo "PROXY_TO is empty"
   exit 2
fi

if [ $PROXY_CERT == "INTERNAL"]; then
   tls_internal="tls internal"
fi

# write caddyfile
cat > /etc/caddy/Caddyfile << EOF
$PROXY_FROM {
  tls_internal
  reverse_proxy $PROXY_TO  
} 
EOF

# start caddy
echo "starting caddy..."
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile 