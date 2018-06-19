FROM ubuntu:latest
RUN apt-get -y update && apt-get install -y --no-install-recommends \
		build-essential \
		pkg-config \
		sudo \
        ninja-build \
        qt5-default \
       	qttools5-dev \
        qt5-image-formats-plugins \
        libqt5sql5-mysql \
        libmysqlclient20 \
        git \
        wget \
	&& rm -rf /var/lib/apt/lists/* 
RUN wget https://cmake.org/files/v3.11/cmake-3.11.4-Linux-x86_64.sh --no-check-certificate \
    && sh cmake-3.11.4-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir \
    && cmake --version
RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user \
    && useradd -m -d /home/user user
USER user 
ENV HOME=/home/user 
WORKDIR /home/user
#CMD ["/bin/bash"]
