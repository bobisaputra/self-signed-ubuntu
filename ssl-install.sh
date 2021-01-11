echo  "[ req ]" > san.cf
echo "default_bits       = 2048" >> san.cf
echo "distinguished_name = req_distinguished_name" >> san.cf
echo "req_extensions     = req_ext" >> san.cf
echo "[ req_distinguished_name ]" >> san.cf
echo "countryName                 = Country Name (2 letter code)" >> san.cf
echo "stateOrProvinceName         = State or Province Name (full name)" >> san.cf
echo "localityName               = Locality Name (eg, city)" >> san.cf
echo "organizationName           = Organization Name (eg, company)" >> san.cf
echo "commonName                 = Common Name (e.g. server FQDN or YOUR name)" >> san.cf
echo "[ req_ext ]" >> san.cf
echo "subjectAltName = @alt_names" >> san.cf
echo "[alt_names]" >> san.cf
echo "DNS.1   = 172.0.0.1" >> san.cf
echo "DNS.2   = [your ip or domain]" >> san.cf
echo "DNS.3   = localhost" >> san.cf

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -config san.cf
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;" > /etc/nginx/snippets/self-signed.conf
echo "ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" >> /etc/nginx/snippets/self-signed.conf
echo "ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;" > /etc/nginx/snippets/ssl-params.conf
echo "ssl_prefer_server_ciphers on;" >> /etc/nginx/snippets/ssl-params.conf
echo "ssl_ciphers 'TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-CHACHA20-POLY1305-D:ECDHE-RSA-CHACHA20-POLY1305-D:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA384';"  >> /etc/nginx/snippets/ssl-params.conf
echo "ssl_ecdh_curve secp384r1;" >> /etc/nginx/snippets/ssl-params.conf
echo "ssl_session_cache shared:SSL:10m;" >> /etc/nginx/snippets/ssl-params.conf
echo "ssl_session_tickets off;" >> /etc/nginx/snippets/ssl-params.conf
echo "ssl_stapling on;" >> /etc/nginx/snippets/ssl-params.conf
echo "ssl_stapling_verify on;" >> /etc/nginx/snippets/ssl-params.conf
echo "resolver 8.8.8.8 8.8.4.4 valid=300s;" >> /etc/nginx/snippets/ssl-params.conf
echo "resolver_timeout 5s;" >> /etc/nginx/snippets/ssl-params.conf

#add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
echo 'add_header Strict-Transport-Security "max-age=31536000; includeSubdomains";' >> /etc/nginx/snippets/ssl-params.conf
echo "add_header X-Frame-Options DENY;" >> /etc/nginx/snippets/ssl-params.conf
echo "add_header X-Content-Type-Options nosniff;" >> /etc/nginx/snippets/ssl-params.conf

echo "ssl_dhparam /etc/ssl/certs/dhparam.pem;" >> /etc/nginx/snippets/ssl-params.conf
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

#write on
#sudo nano /etc/nginx/sites-available/default
#server {

    # SSL configuration

   # listen 443 ssl http2 default_server;
   # listen [::]:443 ssl http2 default_server;
   # include snippets/self-signed.conf;
   # include snippets/ssl-params.conf;
   # server_name server_domain_or_IP;
   # include snippets/self-signed.conf;
   # include snippets/ssl-params.conf;
 # }

