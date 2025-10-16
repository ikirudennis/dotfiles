FROM fedora:42

RUN useradd -G wheel dburke && \
	passwd -d dburke && \
	dnf install -y ansible git python3-devel python3-pip util-linux

USER dburke

RUN mkdir -p /home/dburke/.config && \
	chown dburke:dburke /home/dburke/.config

COPY --chown=dburke . /home/dburke/.config/dburke/dotfiles

WORKDIR /home/dburke/.config/dburke/dotfiles
