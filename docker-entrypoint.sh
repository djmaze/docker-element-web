#!/bin/sh
set -euo pipefail

cp config.sample.json config.json

DEFAULT_HS_URL="${DEFAULT_HS_URL:-https://matrix.org}"
DISABLE_GUESTS="${DISABLE_GUESTS:-false}"
DISABLE_LOGIN_LANGUAGE_SELECTOR="${DISABLE_LOGIN_LANGUAGE_SELECTOR:-false}"

sed -i "s;{{DEFAULT_HS_URL}};$DEFAULT_HS_URL;" config.json
sed -i "s;{{DISABLE_GUESTS}};$DISABLE_GUESTS;" config.json
sed -i "s;{{DISABLE_LOGIN_LANGUAGE_SELECTOR}};$DISABLE_LOGIN_LANGUAGE_SELECTOR;" config.json

exec http-server -p 8080 -A 0.0.0.0
