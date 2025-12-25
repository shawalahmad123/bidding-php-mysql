#!/bin/bash
set -e

# Ensure uploads directory exists and has correct ownership
UPLOAD_DIR="/var/www/html/admin/assets/uploads"
mkdir -p "$UPLOAD_DIR"
chown -R www-data:www-data "$UPLOAD_DIR" || true

exec "$@"
