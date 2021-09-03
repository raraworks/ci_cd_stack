FROM debian:buster-slim
LABEL maintainer="rasmanis.raitis@gmail.com"

# UPDATE packages and install essentials
RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install curl wget unzip lsb-release git \
# PHP 8.0
&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
&& apt-get update \
&& apt-get install -y php8.0-fpm php8.0-mbstring php8.0-gd php8.0-bcmath php8.0-zip php8.0-xml php8.0-curl php8.0-intl php8.0-memcached php8.0-imap php8.0-pgsql php8.0-soap \
# COMPOSER
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php --2 \
&&  php -r "unlink('composer-setup.php');" \
&& mv composer.phar /usr/local/bin/composer \
# NODE & NPM
&& curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs && apt-get install -y build-essential \
# YARN
&& npm i -g yarn

CMD ["/bin/bash"]
