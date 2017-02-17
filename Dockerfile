FROM debian:jessie

MAINTAINER Samat Jorobekov <samat.jorobekov@gmail.com>

RUN apt-get update && apt-get install curl wget git -y

# Certificate and repository for PHP
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    wget -O /usr/local/src/dotdeb.gpg https://www.dotdeb.org/dotdeb.gpg && apt-key add /usr/local/src/dotdeb.gpg && \
    # Repository for NodeJS
    curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get update && \
    apt-get install acl \
                    software-properties-common \

                    # PHP
                    php7.0 \
                    php7.0-fpm \
                    php7.0-bcmath \
                    php7.0-intl \
                    php7.0-zip \
                    php7.0-opcache \
                    php7.0-xml \
                    php7.0-pdo \
                    php7.0-pgsql \
                    php7.0-mbstring \
                    php-pear pkg-config php7.0-dev \

                    # Supervisor
                    supervisor \

                    # NodeJS
                    nodejs build-essential \
                    -y

# Install Nginx
ADD ./scripts/nginx_install.sh /nginx_install.sh
RUN ./nginx_install.sh

RUN apt-get clean && apt-get autoclean

RUN mkdir -p /var/run/php
RUN mkdir /var/www/.npm -p

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
