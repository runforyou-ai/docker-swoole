FROM phpswoole/swoole:6.2.3-php8.5

ARG UID=1000
ARG GID=1000

RUN apt update && apt install -y --no-install-recommends \
    vim \
    tzdata \
    locales \
    nginx \
    git \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    zlib1g-dev \
    libevent-dev \
    libmcrypt-dev \
    procps \
    iputils-ping \
    libicu-dev \
    unzip \
    curl \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt install -y nodejs \
    && sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && usermod -u ${UID} www-data \
    && groupmod -g ${GID} www-data \
    && pecl channel-update pecl.php.net \
    && docker-php-ext-install \
    opcache \
    pdo_pgsql \
    bcmath \
    zip \
    gd \
    pcntl \
    intl \
    && apt install -y libzstd-dev \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apt autoremove -y && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/
USER www-data

