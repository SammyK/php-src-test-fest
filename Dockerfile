FROM ubuntu:16.04

MAINTAINER Sammy Kaye Powers

RUN apt-get update \
	&& apt-get install sudo vim git -y \
	&& apt-get install build-essential autoconf valgrind -y \
	&& apt-get install re2c bison -y \
	&& apt-get install zlib1g-dev -y \
	&& apt-get install libxml2-dev locales lcov -y \
	&& apt-get install libsodium-dev libsodium18 -y

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN groupadd developers \
	&& adduser --disabled-password --gecos "" --ingroup developers tester \
	&& echo "tester:test123" | chpasswd \
	&& touch /etc/sudoers.d/tester \
	&& chmod 0440 /etc/sudoers.d/tester \
	&& echo 'tester ALL=(ALL) ALL' | tee -a /etc/sudoers.d/tester

RUN echo 'PS1="\[\033[31m\]\u@💩 \[\033[34m\]\W\[\033[32m\] \\$\[\033[0m\] "' >> /root/.bashrc
RUN echo 'PS1="\[\033[36m\]\u@💩 \[\033[34m\]\W\[\033[32m\] \\$\[\033[0m\] "' >> /home/tester/.bashrc

EXPOSE 8888
