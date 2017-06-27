FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r11

MAINTAINER Bitnami <containers@bitnami.com>

RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update && apt-get install -t jessie-backports -y openjdk-8-jdk-headless
RUN install_packages git subversion openssh-server rsync libjemalloc1 libxslt1.1 libtidy-0.99-0 libmcrypt4 libicu52 
RUN mkdir /var/run/sshd && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV BITNAMI_APP_NAME=che-laravel \
    BITNAMI_IMAGE_VERSION=5.4.23-r0 \
    LARAVEL_ENV=development \
    NODE_PATH=NODE_PATH=/opt/bitnami/node/lib/node_modules \
    PATH=/opt/bitnami/java/bin:/opt/bitnami/node/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/common/bin:~/.composer/vendor/bin:$PATH

# Install Laravel dependencies
RUN bitnami-pkg install node-6.11.0-0 --checksum 203d22e3357eb5e8573c8d95691f01e1a2a3badcfc2baee0bf83b3ad91dfeb86
RUN bitnami-pkg install php-7.0.20-0 --checksum 78181d1320567be07448e75e4783ce0269b433fc9e7ed8eff67abcff7f7327e9
RUN bitnami-pkg install mariadb-10.1.24-1 --checksum 0ad8567f9d3d8371f085b56854b5288be38c85a5cb3cd4e36d8355eb6bbbd4cd -- --password=laravelSample --username=laravelSample --database=laravelSample --allowEmptyPassword yes

RUN npm install -g gulp

# Laravel template
RUN mkdir /tmp/laravel-sample && cd /tmp/laravel-sample && composer create-project "laravel/laravel=5.4.23" /tmp/laravel-sample --prefer-dist

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

CMD sudo /usr/sbin/sshd -D
