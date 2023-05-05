#!/bin/sh

if [ ! -f "$CERT_DIR/$CERT_NAME.crt" ]; then
	SUBJ="/C=$COUNTRY/ST=$STATE/O=$ORGANIZATION/CN=$DOMAIN_NAME"

	echo " ---> Generate CA private key"
	openssl genrsa \
	    -out "$CERT_DIR/$CERT_NAME.key" \
		"$RSA_KEY_NUMBITS"
	echo " ---> Generate CA certificate request"
	openssl req \
		-new \
		-key "$CERT_DIR/$CERT_NAME.key" \
		-out "$CERT_DIR/$CERT_NAME.csr" \
		-subj "$SUBJ"
	echo " ---> Generate self-signed CA certificate"
	openssl req \
		-x509 \
		-key "$CERT_DIR/$CERT_NAME.key" \
		-in "$CERT_DIR/$CERT_NAME.csr" \
		-out "$CERT_DIR/$CERT_NAME.crt" \
		-days 365
fi

envsubst '${CERT_DIR}${CERT_NAME}' < /etc/nginx/https.d/ssl.template > /etc/nginx/https.d/ssl.conf
exec nginx -g "daemon off;"
