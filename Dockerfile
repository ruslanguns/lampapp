FROM linode/lamp

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
    php5-mysql && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Reparando servicios
RUN chown -R mysql:mysql /var/lib/mysql
RUN mv /var/www/example.com /var/www/myapp

COPY --chown=www-data:www-data myapp /var/www/myapp/public_html

COPY myapp.conf /etc/apache2/sites-available/
RUN  rm -rf /etc/apache2/sites-available/example.com.conf
RUN  rm -rf /etc/apache2/sites-enabled/example.com.conf
RUN     a2ensite myapp.conf

COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/bin/bash", "-lc", "/run.sh"]
