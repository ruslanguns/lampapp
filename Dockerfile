FROM ruslanguns/lamp
LABEL maintainer="Ruslan Gonzalez <ruslanguns@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

#Instalando actualizaciones y paquetes php faltantes
RUN apt-get update && \
    apt-get install -y php5-mysql && \
    apt-get install -y php5-mcrypt && \
    apt-get install -y php5-gd && \
    apt-get install -y php5-curl && \
    apt-get install -y php5-mysqlnd && \
    apt-get install -y php5-imap && \
    apt-get install -y php5-memcache && \
    apt-get install -y php5-ming && \
    apt-get install -y php5-ps && \
    apt-get install -y php5-pspell && \
    apt-get install -y php5-recode && \
    apt-get install -y php5-snmp && \
    apt-get install -y php5-sqlite && \
    apt-get install -y php5-tidy && \
    apt-get install -y php5-xmlrpc && \
    apt-get install -y php5-xsl && \
    apt-get install -y php5-dev && \
    apt-get install -y libapache2-mod-auth-mysql && \
    apt-get install -y libmcrypt-dev && \
    php5enmod mysql mcrypt gd curl mysqlnd imap memcache ming ps pspell recode snmp sqlite tidy xmlrpc xsl dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Reparando servicios de linode/lamp
RUN chown -R mysql:mysql /var/lib/mysql
RUN mv /var/www/example.com /var/www/myapp

#Copiando contenido de la carpeta myapp a public_html
COPY --chown=www-data:www-data myapp /var/www/myapp/public_html

#Copiando configuracion apache2
COPY myapp.conf /etc/apache2/sites-available/

#Copiando php.ini
COPY php5 /etc/

# Install sshd
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Set password to 'admin'
RUN printf rootPassword\\nrootPassword\\n | passwd

# Instalacion de phpmyadmin
RUN apt-get install -y phpmyadmin apache2-utils 

RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

#Elimiando example.com.conf de apache2 ya que no lo usaremos
RUN  rm -rf /etc/apache2/sites-available/example.com.conf \
     /etc/apache2/sites-enabled/example.com.conf

#Añadiendo myapp.conf
RUN  a2ensite myapp.conf

#Habilitando mod_rewrite en Apache2
RUN  a2enmod rewrite

# EXPOSE puertos que se utilizarán
EXPOSE 22
EXPOSE 80
EXPOSE 3306

#Instalación de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
&& ln -s $(composer config --global home) /root/composer  

#Iniciando el script run.sh
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/bin/bash", "-lc", "/run.sh"]
