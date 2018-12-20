FROM naftulikay/bionic-vm:latest
MAINTAINER Naftuli Kay <me@naftuli.wtf>

# install keys (elementary builds and launchpad elementary PPA)
RUN apt-key adv --keyserver ipv4.pool.sks-keyservers.net --recv-keys \
  6CA297B211EEBF8E03ADA1AFA74F73EFFE70B91C \
  6C8769CEDC20F5E66C3B7D37BF36996C4E1F8A59

# deploy configuration
RUN find /etc/apt/sources.list.d -type f -iname '*.list' -delete
COPY --chown=root:root etc/apt/sources.list /etc/apt/sources.list
COPY --chown=root:root etc/apt/sources.list.d/* /etc/apt/sources.list.d/

RUN mkdir -p /etc/upstream-release
COPY --chown=root:root etc/upstream-release/lsb-release /etc/upstream-release/lsb-release
COPY --chown=root:root etc/issue etc/issue.net etc/lsb-release /etc/

RUN ln -sf '../usr/lib/os-release' /etc/os-release
COPY --chown=root:root usr/lib/os-release /usr/lib

# TODO we use our own systemd-await-target because juno takes a long time to boot
COPY --chown=root:root bin/systemd-await-target /usr/local/sbin/
RUN chmod 0700 /usr/local/sbin/systemd-await-target

# install the elementary-desktop metapackage
RUN apt-get update >/dev/null \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y elementary-desktop \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

ENTRYPOINT ["/lib/systemd/systemd"]
