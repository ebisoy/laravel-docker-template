FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN mkdir /app

COPY . /app

WORKDIR /app

COPY ./.env.prod /app/.env

RUN composer install

RUN php artisan key:generate

RUN php artisan config:cache

RUN php artisan optimize

EXPOSE $PORT

CMD php artisan serve --host=0.0.0.0 --port=$PORT