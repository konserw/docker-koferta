FROM archlinux/base:latest
RUN pacman -Syu --noconfirm -q \
    && pacman -S --noconfirm --needed -q cmake qt5-base clang ninja git base-devel libmariadbclient \
    && pacman -Scc --noconfirm \
	&& echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user \
	&& rm -rf /var/lib/apt/lists/* \
    && useradd -m -d /home/user user
USER user 
ENV HOME=/home/user 
WORKDIR /home/user
#CMD ["/bin/bash"]
