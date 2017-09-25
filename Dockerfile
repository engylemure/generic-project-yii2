FROM andremetzen/alpine-php-fpm
MAINTAINER Andre Metzen <metzen@conceptho.com>

WORKDIR /srv/www

RUN docker-php-ext-install exif


RUN npm install -g bower

ADD src/docker/files /src
RUN cp -rf /src/* /
RUN rm -rf /src

ADD src/www /srv/www

#RUN composer --working-dir=/srv/www install --no-dev -v --prefer-dist && composer clear-cache
#RUN composer --working-dir=/srv/www dumpautoload -o
#RUN chmod 0777 /srv/www/runtime /srv/www/web/assets /srv/www/web/runtime/export

#ENV PATH /root/.composer/vendor/bin:$PATH

CMD ["bash", "/start.sh"]