FROM naftulikay/bionic-vm:latest
MAINTAINER Naftuli Kay <me@naftuli.wtf>

# install keys (elementary builds and launchpad elementary PPA)
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
  6CA297B211EEBF8E03ADA1AFA74F73EFFE70B91C \
  6C8769CEDC20F5E66C3B7D37BF36996C4E1F8A59

# deploy configuration
RUN sudo find /etc/apt/sources.list.d -type f -iname '*.list' -delete
COPY --chown=root:root etc/apt/sources.list /etc/apt/sources.list
COPY --chown=root:root etc/apt/sources.list.d/* /etc/apt/sources.list.d/

RUN sudo mkdir -p /etc/upstream-release
COPY --chown=root:root etc/upstream-release/lsb-release /etc/upstream-release/lsb-release
COPY --chown=root:root etc/issue etc/issue.net etc/lsb-release /etc/

RUN sudo ln -sf '../usr/lib/os-release' /etc/os-release
COPY --chown=root:root usr/lib/os-release /usr/lib

# install the elementary-desktop metapackage
RUN sudo apt-get update >/dev/null \
  && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y elementary-desktop \
  && sudo rm -rf /var/lib/apt/lists/* \
  && sudo apt-get clean

ENTRYPOINT ["/usr/sbin/escalator", "/lib/systemd/systemd", "--", "--system", "--unit=multi-user.target"]
