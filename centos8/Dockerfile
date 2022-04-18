# Use the official image as a parent image.
FROM centos:centos8

ENV container docker

# Set the working directory.
WORKDIR /

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y upgrade
RUN dnf -y group install "Development Tools"
RUN dnf -y install openssl-devel
RUN git clone https://github.com/Kitware/CMake.git
RUN cd /CMake && ./bootstrap && make -j10 && make install
RUN dnf --enablerepo=powertools install ninja-build

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]
