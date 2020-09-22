sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
echo ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt; > /etc/nginx/snippets/self-signed.conf
echo ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key; >> /etc/nginx/snippets/self-signed.conf
echo ssl_protocols TLSv1 TLSv1.1 TLSv1.2; > /etc/nginx/snippets/ssl-params.conf
echo ssl_prefer_server_ciphers on; >> /etc/nginx/snippets/ssl-params.conf
echo echo ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH"; >> /etc/nginx/snippets/ssl-params.conf
echo ssl_ecdh_curve secp384r1; >> /etc/nginx/snippets/ssl-params.conf
echo ssl_session_cache shared:SSL:10m; >> /etc/nginx/snippets/ssl-params.conf
echo ssl_session_tickets off; >> /etc/nginx/snippets/ssl-params.conf
echo ssl_stapling on; >> /etc/nginx/snippets/ssl-params.conf
echo ssl_stapling_verify on; >> /etc/nginx/snippets/ssl-params.conf
echo resolver 8.8.8.8 8.8.4.4 valid=300s; >> /etc/nginx/snippets/ssl-params.conf
echo resolver_timeout 5s; >> /etc/nginx/snippets/ssl-params.conf

#add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
echo add_header Strict-Transport-Security "max-age=63072000; includeSubdomains"; >> /etc/nginx/snippets/ssl-params.conf
echo add_header X-Frame-Options DENY; >> /etc/nginx/snippets/ssl-params.conf
echo add_header X-Content-Type-Options nosniff; >> /etc/nginx/snippets/ssl-params.conf

echo ssl_dhparam /etc/ssl/certs/dhparam.pem; >> /etc/nginx/snippets/ssl-params.conf
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

#sudo nano /etc/nginx/sites-available/default
#server {

    # SSL configuration

   # listen 443 ssl http2 default_server;
   # listen [::]:443 ssl http2 default_server;
   # include snippets/self-signed.conf;
   # include snippets/ssl-params.conf;
 # }

