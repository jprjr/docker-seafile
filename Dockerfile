FROM jprjr/arch

MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy --noconfirm --quiet > /dev/null

# things that can be removed later
RUN pacman -S --noconfirm --quiet --needed base-devel > /dev/null 2>/dev/null
RUN pacman -S --noconfirm --quiet --needed --asdeps git jshon expac > /dev/null 2>/dev/null

# things I should probably keep
RUN pacman -S --noconfirm --quiet --needed --asexplicit grep sed curl tar file >/dev/null 2>/dev/null

RUN mkdir /tmp/packer && \
    cd /tmp/packer && \
    curl -R -L -O https://aur.archlinux.org/packages/pa/packer/PKGBUILD 2>/dev/null && \
    makepkg --asroot -i --noconfirm >/dev/null 2>/dev/null && \
    cd / && rm -rf /tmp/packer

RUN packer -S --noconfirm --noedit seafile-server > /dev/null 2>/dev/null

# make user
RUN useradd -m -d /srv/seafile -s /bin/false seafile
RUN mkdir /opt/scripts

ADD seahub_setup.sh /opt/scripts/seahub_setup.sh
ADD seafile_setup.sh /opt/scripts/seafile_setup.sh
ADD seafile_start.sh /opt/scripts/seafile_start.sh

RUN pacman -Ru --noconfirm packer git
RUN pacman -R --noconfirm $(pacman -Qdtq)
RUN pacman -Ru --noconfirm base-devel
RUN pacman -R --noconfirm $(pacman -Qdtq)
RUN paccache -rk0
RUN pacman -Scc --noconfirm
 
WORKDIR /srv/seafile
USER seafile
VOLUME /srv/seafile
  
ENTRYPOINT /opt/scripts/seafile_start.sh

# Please look at the readme! There's some interactive setup you'll need to do!
