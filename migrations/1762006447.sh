#!/usr/bin/env bash

##########################################
# Generate SSL certs for dotnet          #
##########################################

TMP_PATH=/var/tmp/localhost-dev-cert
mkdir -p "$TMP_PATH"

KEYFILE=$TMP_PATH/dotnet-devcert.key
CRTFILE=$TMP_PATH/dotnet-devcert.crt
PFXFILE=$TMP_PATH/dotnet-devcert.pfx
CONF_PATH=$TMP_PATH/localhost.conf

NSSDB_PATHS="$HOME/.pki/nssdb \
    $HOME/snap/chromium/current/.pki/nssdb \
    $HOME/snap/postman/current/.pki/nssdb"

# Configure NSS DB for browsers
configure_nssdb() {
    NSSDB="$1"
    echo "Configuring NSS DB: $NSSDB"
    certutil -d sql:"$NSSDB" -D -n dotnet-devcert
    certutil -d sql:"$NSSDB" -A -t "CP,," -n dotnet-devcert -i "$CRTFILE"
}

# Generate openssl config
cat > "$CONF_PATH" <<EOF
[req]
prompt                  = no
default_bits            = 2048
distinguished_name      = subject
req_extensions          = req_ext
x509_extensions         = x509_ext

[ subject ]
commonName              = localhost

[req_ext]
basicConstraints        = critical, CA:true
subjectAltName          = @alt_names

[x509_ext]
basicConstraints        = critical, CA:true
keyUsage                = critical, keyCertSign, cRLSign, digitalSignature,keyEncipherment
extendedKeyUsage        = critical, serverAuth
subjectAltName          = critical, @alt_names
1.3.6.1.4.1.311.84.1.1  = ASN1:UTF8String:ASP.NET Core HTTPS development certificate

[alt_names]
DNS.1                   = localhost
EOF

# Generate the certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "$KEYFILE" -out "$CRTFILE" -config "$CONF_PATH" --passout pass:
openssl pkcs12 -export -out "$PFXFILE" -inkey "$KEYFILE" -in "$CRTFILE" --passout pass:

# Configure NSS DBs
for NSSDB in $NSSDB_PATHS; do
    [ -d "$NSSDB" ] && configure_nssdb "$NSSDB"
done

# Remove old trust cert 
OLD_CRT=/etc/ca-certificates/trust-source/localhost.p11-kit
if [ -f "$OLD_CRT" ]; then
    [ -z "$SUDO" ] && SUDO='sudo'
    $SUDO rm "$OLD_CRT"
fi

# import the new one
[ -z "$SUDO" ] && SUDO='sudo'
$SUDO trust anchor --store "$CRTFILE"
$SUDO trust extract-compat

# Import to dotnet dev-certs
dotnet dev-certs https --clean --import "$PFXFILE" -p ""

# Cleanup temporary files
rm -rf "$TMP_PATH"
