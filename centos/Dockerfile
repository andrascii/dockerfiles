# Use the official image as a parent image.
FROM centos:centos7

ENV container docker

# Set the working directory.
WORKDIR /

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

RUN yum -y upgrade
RUN yum makecache

# installing dependencies
RUN \
yum -y install \
epel-release \
which \
screen \
openssl-devel \
git \
curl \
zip \
unzip \
tar \
gcc-c++ make \
ninja-build \
centos-release-scl \
devtoolset-7

# creating admin
RUN useradd apugachev
RUN usermod apugachev -g root
RUN echo -e "password\npassword" | passwd apugachev

RUN \
echo "#!/bin/bash\n\n" >> /home/apugachev/.bash_profile && \
echo "scl enable devtoolset-7 bash" >> /home/apugachev/.bash_profile

# installing cmake
RUN git clone https://github.com/Kitware/CMake.git
RUN cd CMake && ./bootstrap && make && make install && cd /

# installing vcpkg
RUN git clone https://github.com/microsoft/vcpkg
RUN cd vcpkg && ./bootstrap-vcpkg.sh
RUN echo "export PATH=$PATH:/vcpkg" >> /home/apugachev/.bash_profile
RUN echo "export VCPKG_CMAKE_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake" >> /home/apugachev/.bash_profile

# add repository to download and install node.js
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -

# install node.js and their dependencies
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
