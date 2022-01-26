FROM debian:buster-slim
LABEL maintainer="rasmanis.raitis@gmail.com"

# UPDATE packages and install essentials
RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get -y install curl wget unzip lsb-release git build-essential \
# PHP 8.0
&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
&& apt-get update \
&& apt-get install -y php8.0-fpm \
# COMPOSER V2
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php --2 \
&&  php -r "unlink('composer-setup.php');" \
&& mv composer.phar /usr/local/bin/composer \
# NODE & NPM
&& curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs && npm install -g npm@latest \
# YARN
&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update && apt-get install -y yarn

CMD ["/bin/bash"]
