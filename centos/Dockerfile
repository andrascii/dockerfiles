# Use the official image as a parent image.
FROM centos:centos7

ENV container docker

# Set the working directory.
WORKDIR /

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

RUN yum -y install epel-release
RUN yum -y install htop
RUN yum -y install tmux

# add repository to download and install node.js
RUN yum -y install curl
RUN yum -y install wget
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -

# install node.js and their dependencies
RUN yum -y install gcc-c++ make
RUN yum -y install nodejs

# https://hub.docker.com/_/centos/
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]
