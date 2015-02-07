FROM debian:jessie
MAINTAINER Jake <i@am.so-aweso.me>

# Install components
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get --no-install-recommends -qyy install sudo deluged deluge-web deluge-console runit psmisc nginx php5-fpm unzip wget php5-gd libav-tools zip imagemagick apache2-utils && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN useradd -m -s /bin/nologin deluge
RUN sudo -u deluge sh -c "deluged; sleep 5; killall deluged"
RUN sudo -u deluge sh -c "echo \"deluge:deluge:10\" >> ~/.config/deluge/auth"
RUN sudo -u deluge sh -c "deluged && sleep 10 && deluge-console \"config -s allow_remote True\" && deluge-console \"config allow_remote\" && killall deluged"
RUN mkdir -p /etc/service/deluged; mkdir -p /etc/service/deluge-web; mkdir -p /etc/service/php5-fpm; mkdir -p /etc/service/nginx

# Configure nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/sites-available/default

# Configure runit
ADD deluged.service /etc/service/deluged/run
ADD deluge-web.service /etc/service/deluge-web/run
ADD php5-fpm.service /etc/service/php5-fpm/run
ADD nginx.service /etc/service/nginx/run

ADD core.conf /tmp/core.conf
WORKDIR /home/deluge

# Expose ports
EXPOSE 80
EXPOSE 8112
EXPOSE 58846
EXPOSE 58847
EXPOSE 58847/udp

VOLUME /home/deluge
CMD ["runsvdir", "/etc/service"]
