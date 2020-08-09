FROM debian:stable
LABEL maintainer "rasmanis.raitis@gmail.com"

# UPDATE packages and install essentials
RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install curl wget build-essential apt-transport-https software-properties-common tzdata unzip bzip2 cron vim lsb-release ca-certificates nginx \
&& apt-get install -y nasm pkg-config libpng-dev automake libtool autoconf \
# Set Europe/Riga timezone
&& ln -fs /usr/share/zoneinfo/Europe/Riga /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# PHP 7.4
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
&& apt-get update \
&& apt-get install -y php7.4-fpm php7.4-mbstring php7.4-gd php7.4-bcmath php7.4-zip php7.4-xml php7.4-curl php7.4-intl php7.4-memcached php7.4-imap php7.4-pgsql php7.4-soap

# COMPOSER
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php \
&&  php -r "unlink('composer-setup.php');" \
&& mv composer.phar /usr/local/bin/composer \
&& composer global require hirak/prestissimo

# NODE & NPM
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs && apt-get install -y build-essential

# RSYNC
RUN apt-get install -y ssh rsync

CMD ["/bin/bash"]