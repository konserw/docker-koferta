FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

#setup locale
RUN apt-get -y -qq update \
    && apt-get install -q -y --no-install-recommends locales \
	&& rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_LANG en_US.UTF-8

#install basics
RUN apt-get -y -qq update \
    && apt-get install -q -y --no-install-recommends \
xvfb vim build-essential sudo gosu ninja-build wget software-properties-common lcov rubygems git ssh \
	&& rm -rf /var/lib/apt/lists/* \
    && echo "StrictHostKeyChecking no" > /etc/ssh/ssh_config \
    && echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

# install coveralls gem
RUN gem install coveralls-lcov

#install cmake 3.11 from official site
RUN wget https://cmake.org/files/v3.11/cmake-3.11.4-Linux-x86_64.sh --no-check-certificate -q --server-response \
    && sh cmake-3.11.4-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir 

#install qr 5.11 from apt
RUN add-apt-repository ppa:beineri/opt-qt-5.11.0-bionic -y \
    && apt-get -y -qq update \
    && apt-get install -q -y --no-install-recommends \
        mesa-common-dev \
        qt511base \
       	qt511tools \
	&& rm -rf /var/lib/apt/lists/* 
ENV QTDIR "/opt/qt511"
ENV PATH "$QTDIR/bin:$PATH"
ENV CMAKE_PREFIX_PATH "/opt/qt511/lib/cmake/"

#install mariadb
ENV DATABASE kOferta_test
ADD run_db /usr/local/bin/run_db
RUN apt-get -y -qq update \
    && apt-get install -q -y --no-install-recommends mariadb-server \
	&& rm -rf /var/lib/apt/lists/* \
    && chmod +x /usr/local/bin/run_db \
    && mkdir /var/run/mysqld \
    && chown mysql:mysql /var/run/mysqld
#    && sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf \
#    && update-rc.d -f mysql disable

#add normal user
RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user \
    && useradd -m -d /home/user user
USER user 
ENV USER user
ENV HOME=/home/user 
WORKDIR /home/user

#run 
#VOLUME ["/var/lib/mysql"]
#EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/run_db"]
#CMD ["/usr/local/bin/run_db"]
CMD ["/bin/bash"]

#for debugging
#RUN apt-get -y -qq update \
#    && apt-get install -q -y --no-install-recommends vim 
# apt-file vim pkg-config

