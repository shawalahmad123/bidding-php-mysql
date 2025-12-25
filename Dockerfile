FROM php:8.1-apache

# Install system deps and mysqli
RUN apt-get update \
    && apt-get install -y --no-install-recommends libzip-dev zip unzip libpng-dev libjpeg-dev libxml2-dev \
    && docker-php-ext-install mysqli \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Add PHP configuration
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Add entrypoint that ensures upload dir ownership
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
