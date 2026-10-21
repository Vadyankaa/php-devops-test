
FROM php:8.2-fpm

LABEL org.opencontainers.image.title="PHP FileManager"
LABEL org.opencontainers.image.description="PHP-FPM container for FileManager"

WORKDIR /var/www/html

COPY --chown=www-data:www-data src/ /var/www/html/

# Создаём каталог для пользовательских файлов
RUN mkdir -p /var/www/html/home \
    && chown www-data:www-data /var/www/html/home

EXPOSE 9000

CMD ["php-fpm"]
