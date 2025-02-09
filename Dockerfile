FROM ubuntu:jammy
RUN sed '/security/d' -i /etc/apt/sources.list \
	&& sed '/jammy-updates/d' -i /etc/apt/sources.list \
	&& apt update \
	&& apt install -y wget curl unzip nano jq nginx \
	&& apt clean \
	&& mkdir /opt/cpolar
WORKDIR /opt/cpolar

RUN wget https://www.cpolar.com/static/downloads/releases/3.3.12/cpolar-stable-linux-amd64.zip \
	&& unzip cpolar-stable-linux-amd64.zip && rm -rf cpolar-stable-linux-amd64.zip

ADD ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ADD ./ui.conf /etc/nginx/conf.d/

COPY ./config.sh /
RUN chmod +x /config.sh
COPY ./monitor.sh /
RUN chmod +x /monitor.sh

#install openjdk21
RUN mkdir /opt/java
WORKDIR /opt/java
RUN wget https://download.java.net/openjdk/jdk8u44/ri/openjdk-8u44-linux-x64.tar.gz
RUN tar -zxvf ./openjdk-8u44-linux-x64.tar.gz \
        && rm -rf ./openjdk-8u44-linux-x64.tar.gz
ENV JAVA_HOME=/opt/java/java-se-8u44-ri
RUN ln -s /opt/java/java-se-8u44-ri/bin/java /usr/bin/java
RUN ln -s /opt/java/java-se-8u44-ri/bin/javac /usr/bin/javac

WORKDIR /opt
RUN mkdir -p /opt/bin
RUN mkdir -p /opt/lib
COPY ./mail-cli.jar /opt/bin/
ENV URL=
ENV DOMAIN=
ENV TOKEN=

ENV SMTP_HOST=
ENV SMTP_PORT=
ENV SMTP_USER=
ENV SMTP_PASSWD=
ENV SMTP_FROM=
ENV SMTP_TO=

ENV MSUBJECT=

ENTRYPOINT /docker-entrypoint.sh

RUN echo "alias ll='ls -l -a'" >> /root/.bashrc
RUN echo export LANG="C.UTF-8" >> /root/.bashrc
