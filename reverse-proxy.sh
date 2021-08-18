#!/bin/sh

if [ ! -z $PROXY_CFG ]; then
   echo "PROXY_CFG is given -> write into caddyfile"
   echo "$PROXY_CFG" > /etc/caddy/Caddyfile
else
   # check for environment variables
   if [ -z $PROXY_FROM ]; then
      echo "PROXY_FROM is empty"
      exit 2
   fi

   if [ -z $PROXY_TO ]; then
      echo "PROXY_TO is empty"
      exit 2
   fi

   if [ $PROXY_CERT == "INTERNAL" ]; then
      tls_directive="tls internal"
   elif [ $PROXY_CERT == "" ]; then
      tls_directive=""
   else
      if [ -z $PROXY_CA_CRT ]; then
         echo "PROXY_CA_CRT is empty"
         exit 2
      fi
      # write cert into file
      echo "$PROXY_CA_CRT" > /etc/caddy/ca_root.pem

      tls_directive="tls {
         ca $PROXY_CERT
         ca_root /etc/caddy/ca_root.pem
         }"
   fi

   # write caddyfile
   cat > /etc/caddy/Caddyfile << EOF
   $PROXY_FROM {
   $tls_directive
   reverse_proxy $PROXY_TO  
   } 
   EOF

fi

# start caddy
echo "starting caddy..."
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile 