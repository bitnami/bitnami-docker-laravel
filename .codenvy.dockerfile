FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r19

MAINTAINER Bitnami <containers@bitnami.com>

RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update && apt-get install -t jessie-backports -y openjdk-8-jdk-headless
RUN install_packages git subversion openssh-server rsync libjemalloc1 libxslt1.1 libtidy-0.99-0 libmcrypt4 libicu52 
RUN mkdir /var/run/sshd && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV BITNAMI_APP_NAME=che-laravel \
    BITNAMI_IMAGE_VERSION=5.4.30-r0 \
    LARAVEL_ENV=development \
    NODE_PATH=NODE_PATH=/opt/bitnami/node/lib/node_modules \
    PATH=/opt/bitnami/java/bin:/opt/bitnami/node/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/common/bin:~/.composer/vendor/bin:$PATH

# Install Laravel dependencies
RUN bitnami-pkg install node-6.11.1-0 --checksum 30c14d5d23328aafdfe6d63a8956a8cca4eb6bf4f13cbdc6a080a05731b614c1
RUN bitnami-pkg install php-7.1.7-0 --checksum e89b2b7a83ba84fb66f2bbe13c82a68b5625bed10fa3150f561eec95157d0680
RUN bitnami-pkg install mariadb-10.1.25-0 --checksum 599b1e6d9c3984e65fe1ee7fa7f884250cff9c589360b89bb33e91ea91404092 -- --password=laravelSample --username=laravelSample --database=laravelSample --allowEmptyPassword yes

RUN npm install -g gulp

# Laravel template
RUN mkdir /tmp/laravel-sample && cd /tmp/laravel-sample && composer create-project "laravel/laravel=5.4.30" /tmp/laravel-sample --prefer-dist

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
