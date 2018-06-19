FROM ubuntu:latest
RUN apt-get -y update && apt-get install -y --no-install-recommends \
		build-essential \
		cmake \
		pkg-config \
		sudo \
        ninja-build \
        qt5-default \
       	qttools5-dev \
        qt5-image-formats-plugins \
        libqt5sql5-mysql \
        libmysqlclient20 \
        git \
	&& rm -rf /var/lib/apt/lists/* \
	&& echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user \
    && useradd -m -d /home/user user
USER user 
ENV HOME=/home/user 
WORKDIR /home/user
#CMD ["/bin/bash"]
