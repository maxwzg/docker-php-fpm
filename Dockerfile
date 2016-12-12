FROM php:5.6.28-fpm

MAINTAINER WuZhiGang "11036407@qq.com"
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        ssmtp \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libbz2-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libenchant-dev \
        libssh-dev \
        libssh2-1-dev \
        libgmp-dev \
        libncurses5-dev \
        libldap2-dev \
        libc-client-dev \
        libkrb5-dev \
        libicu-dev \
        libsqlite3-dev \
        libeditline-dev \
        libtidy-dev \
        libxslt-dev \
        libmagickwand-dev \
        libmagickcore-dev \
        libmemcached-dev &&\
        rm -rf /var/lib/apt/lists/*

RUN wget https://getcomposer.org/download/1.2.0/composer.phar -O /usr/local/bin/composer && \
    chmod a+rx /usr/local/bin/composer

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    ln -fs /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && \
    docker-php-ext-configure mysql --with-mysql=mysqlnd && \
    docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/lib

RUN docker-php-ext-install -j$(nproc) iconv \
    mcrypt \
    bcmath \
    bz2 \
    calendar \
    ctype \
    curl \
    dba \
    dom \
    enchant \
    exif \
    fileinfo \
    gettext \
    gmp \
    hash \
    gd \
    imap \
    intl \
    json \
    ldap \
    mbstring \
    mysql \
    mysqli \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    pdo_sqlite \
    phar \
    posix \
    readline \
#    reflection\
    session \
    simplexml \
    soap \
    sockets \
#    spl
#    standard \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    tokenizer \
    xml \
    xmlreader \
    xmlrpc \
    xmlwriter \
    xsl \
    zip

#RUN pecl install xdebug-2.4.0 && \
#    pecl install mongo-1.6.14 && \
#    pecl install memcached-2.2.0 && \
#    pecl install redis-2.2.8 && \
#    pecl install amqp-1.4.0 && \
#    pecl install ssh2-0.12 && \
#    pecl install yaml-1.2.0 && \
#    pecl install varnish-1.2.1 && \
#    pecl install imagick-3.4.1 && \
#    rm -rf /tmp/*

RUN pecl install xdebug && \
    pecl install memcached && \
    pecl install redis && \
    pecl install imagick && \
    rm -rf /tmp/*

RUN docker-php-ext-enable redis && \
    docker-php-ext-enable imagick && \
    docker-php-ext-enable memcached && \

EXPOSE 9000
CMD ["php-fpm"]