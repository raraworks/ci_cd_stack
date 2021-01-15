FROM debian:buster-slim
LABEL maintainer "rasmanis.raitis@gmail.com"

# UPDATE packages and install essentials
RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install curl wget unzip lsb-release git \
# PHP 7.4
&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
&& apt-get update \
&& apt-get install -y php7.4-fpm php7.4-mbstring php7.4-gd php7.4-bcmath php7.4-zip php7.4-xml php7.4-curl php7.4-intl php7.4-memcached php7.4-imap php7.4-pgsql php7.4-soap \
# COMPOSER
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php \
&&  php -r "unlink('composer-setup.php');" \
&& mv composer.phar /usr/local/bin/composer \
# NODE & NPM
&& curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs && apt-get install -y build-essential \
# YARN
&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update && apt-get install -y yarn \
# SSH & RSYNC
&& apt-get install -y ssh rsync

CMD ["/bin/bash"]
