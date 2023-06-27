#!/command/with-contenv /bin/bash
# Download cloudflare credentials from 1Password

op inject -i /etc/templates/cloudflare_credentials.ini.tpl -o /etc/letsencrypt/cloudflare_credentials.ini

# Get the latest sshd_param
wget https://ssl-config.mozilla.org/ffdhe2048.txt -O /etc/letsencrypt/ssl-dhparams.pem
