FROM ubuntu:latest
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
		build-essential \
		pkg-config \
		sudo \
        ninja-build \
        git \
        wget \
        software-properties-common \ 
	&& rm -rf /var/lib/apt/lists/* 
# apt-file
RUN add-apt-repository ppa:beineri/opt-qt-5.11.0-bionic -y \
    && apt-get -y update \
    && apt-get install -y --no-install-recommends \
        mesa-common-dev \
        qt511base \
       	qt511tools \
	&& rm -rf /var/lib/apt/lists/* 
RUN ls /usr/include/GL
RUN wget https://cmake.org/files/v3.11/cmake-3.11.4-Linux-x86_64.sh --no-check-certificate \
    && sh cmake-3.11.4-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir 
RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user \
    && useradd -m -d /home/user user
USER user 
WORKDIR /home/user
ENV HOME=/home/user 
ENV QTDIR="/opt/qt511"
ENV PATH="$QTDIR/bin:$PATH"
ENV CMAKE_PREFIX_PATH="/opt/qt511/lib/cmake/"
CMD ["/bin/bash"]
