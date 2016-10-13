FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r10

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=laravel \
    BITNAMI_IMAGE_VERSION=5.2.31-r6 \
    LARAVEL_ENV=development \
    NODE_PATH=NODE_PATH=/opt/bitnami/node/lib/node_modules \
    PATH=/opt/bitnami/java/bin:/opt/bitnami/node/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/common/bin:~/.composer/vendor/bin:$PATH

# Install Laravel dependencies
RUN bitnami-pkg install node-6.6.0-1 --checksum 36f42bb71b35f95db3bb21d088fbd9438132fb2a7fb4d73b5951732db9a6771e
RUN bitnami-pkg install php-7.0.10-0 --checksum 5f2ec47fcfb2fec5197af6760c5053dd5dee8084d70a488fd5ea77bd4245c6b9
RUN bitnami-pkg install mariadb-10.1.14-4 --checksum 4a75f4f52587853d69860662626c64a4540126962cd9ee9722af58a3e7cfa01b -- --password=laravelSample --username=laravelSample --database=laravelSample

RUN npm install -g gulp

# Laravel template
RUN mkdir /tmp/laravel-sample && cd /tmp/laravel-sample && composer create-project "laravel/laravel=5.2.31" /tmp/laravel-sample --prefer-dist

EXPOSE 3000

# Set up Codenvy integration
LABEL che:server:3000:ref=laravel che:server:3000:protocol=http

USER bitnami
WORKDIR /projects

ENV DB_HOST=127.0.0.1 \
    DB_USERNAME=laravelSample \
    DB_DATABASE=laravelSample \
    DB_PASSWORD=laravelSample \
    TERM=xterm

CMD ["/entrypoint.sh", "tail", "-f", "/dev/null"]
