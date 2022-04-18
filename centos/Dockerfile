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
RUN yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm

RUN \
yum install \
-y epel-release \
-y which \
-y screen \
-y openssl-devel \
-y curl \
-y zip \
-y unzip \
-y tar \
-y make \
-y centos-release-scl \
-y devtoolset-7 \
-y git

# installing cmake
RUN git clone https://github.com/Kitware/CMake.git
RUN cd /CMake && ./bootstrap
RUN cd /CMake && make
RUN cd /CMake && make install

# installing vcpkg
RUN git clone https://github.com/microsoft/vcpkg
RUN cd vcpkg && ./bootstrap-vcpkg.sh
#RUN ./vcpkg install boost
#RUN ./vcpkg install cppkafka
#RUN ./vcpkg install gtest
#RUN ./vcpkg install spdlog
#RUN ./vcpkg install openssl
#RUN ./vcpkg install mio
#RUN ./vcpkg install libpqxx
#RUN ./vcpkg install cxxopts
#RUN ./vcpkg install simdjson
#RUN ./vcpkg install fmt
#RUN ./vcpkg install tl-expected
#RUN ./vcpkg install nlohmann-json
#RUN ./vcpkg install decimal-for-cpp
#RUN ./vcpkg install date
#RUN ./vcpkg install pugixml
#RUN ./vcpkg install libiconv
RUN echo "export PATH=$PATH:/vcpkg" >> /.bash_profile

# creating admin
RUN useradd apugachev
RUN usermod apugachev -g root
RUN echo -e "password\npassword" | passwd apugachev
RUN echo "scl enable devtoolset-7 bash" >> /home/apugachev/.bash_profile
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
