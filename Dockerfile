FROM alpine:3.10
LABEL author="Serge NOEL <serge.easylinux.fr>" \
      version="5.0.0" \
      description="Collection musique en ligne" \
      app="Ampache"

RUN apk add php7-apache2
RUN mkdir /var/www/html
RUN sed -i "s|/var/www/localhost/htdocs|/var/www/html|g" /etc/apache2/httpd.conf
RUN wget https://github.com/ampache/ampache/archive/5.0.0-pre-release.tar.gz
RUN cd /var/www/html \
    && tar zxf /5.0.0-pre-release.tar.gz --strip 1

EXPOSE 80

#CMD httpd -D FOREGROUND
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
 
