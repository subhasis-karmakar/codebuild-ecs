FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/apache2 -y && apt-get update && apt-get install -y apache2 apt-utils
RUN rm -rf /etc/apache2/sites-available/000-default.conf
COPY 000-default.conf /etc/apache2/sites-available/
RUN a2enmod rewrite
RUN rm -rf /var/www/html/*
COPY react/ /var/www/html
RUN find /var/www/html -type d -exec chmod -R 775 {} \; && find /var/www/html -type f -exec chmod -R 664 {} \;
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]

