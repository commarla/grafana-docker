FROM debian:jessie

ENV GRAFANA_VERSION 2.5.1-pre1

COPY sources.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get -y install libfontconfig adduser && \
    apt-get clean

COPY grafana_2.5.1-pre1_amd64.deb /tmp/grafana.deb

RUN dpkg -i /tmp/grafana.deb && rm /tmp/grafana.deb

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

ENTRYPOINT ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini", "cfg:default.paths.data=/var/lib/grafana", "cfg:default.paths.logs=/var/log/grafana"]
