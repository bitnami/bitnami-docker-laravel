FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r8

MAINTAINER Bitnami <containers@bitnami.com>

RUN echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
RUN apt-get update && apt-get install -t jessie-backports -y openjdk-8-jdk-headless
RUN install_packages git subversion openssh-server
RUN mkdir /var/run/sshd && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV BITNAMI_APP_NAME=che-laravel \
    BITNAMI_IMAGE_VERSION=5.2.31-r12 \
    LARAVEL_ENV=development \
    NODE_PATH=NODE_PATH=/opt/bitnami/node/lib/node_modules \
    PATH=/opt/bitnami/java/bin:/opt/bitnami/node/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/common/bin:~/.composer/vendor/bin:$PATH

# Install Laravel dependencies
RUN bitnami-pkg install node-6.6.0-1 --checksum 36f42bb71b35f95db3bb21d088fbd9438132fb2a7fb4d73b5951732db9a6771e
RUN bitnami-pkg install php-7.0.10-0 --checksum 5f2ec47fcfb2fec5197af6760c5053dd5dee8084d70a488fd5ea77bd4245c6b9
RUN bitnami-pkg install mariadb-10.1.19-0 --checksum c54e3fdc689cdd2f2119914e4f255722f96f1d7fef37a064fd46fb84b013da7b -- --password=laravelSample --username=laravelSample --database=laravelSample

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

CMD /usr/sbin/sshd -D && tail -f /dev/null
