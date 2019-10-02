FROM alpine:3.10
LABEL author="Serge NOEL <serge.noel@easylinux.fr>" \
      application="Ampache" \
      version="5.0.0"

# Installation des logiciels nécessaires
RUN apk add apache2 \
            php7-apache2 \
            php7-curl \
            php7-pdo_mysql \
            php7-gd \
            php7-gettext \
            php7-iconv \
            php7-json \
            php7-mysqli \
            php7-session \
            php7-simplexml \
    && wget https://github.com/ampache/ampache/releases/download/5.0.0/5.0.0-pre-release.tar.gz \
    && mkdir -p /var/www/html \
    && cd /var/www/html \
    && tar zxf /5.0.0-pre-release.tar.gz \
    && rm /ampache-3.9.0_all.zip \
    && sed -i 's|/var/www/localhost/htdocs|/var/www/html|g' /etc/apache2/httpd.conf \
    && ln -s /dev/stdout /var/log/apache2/access.log \
    && ln -s /dev/stderr /var/log/apache2/error.log \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 32M/g' /etc/php7/php.ini \
    && chown -R apache: /var/www/html/config \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 64/g" /etc/php7/php.ini
ADD Files/ /

EXPOSE 80
VOLUME /media

CMD /usr/local/bin/ampache

