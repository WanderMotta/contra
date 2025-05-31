#!/bin/bash

domains=(contrato.aplicativoapp.com)
rsa_key_size=4096
data_path="./certbot"
email="" # Pode adicionar um email opcional
staging=0 # Use 1 para ambiente de teste

if [ -d "$data_path/conf/live/${domains[0]}" ]; then
  echo "Certificado já existe para ${domains[0]}"
  exit
fi

mkdir -p "$data_path/www"

echo "### Baixando certificado SSL para ${domains[*]} ..."

docker compose run --rm   -v "$data_path/www:/var/www/certbot"   -v "$data_path/conf:/etc/letsencrypt"   certbot certonly --webroot   --webroot-path=/var/www/certbot   --agree-tos   --no-eff-email   --staple-ocsp   --preferred-challenges http   -m "$email"   -d "${domains[@]}"   ${staging:+--staging}
