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
RUN dnf --enablerepo=powertools -y install ninja-build
RUN dnf -y install python3
RUN dnf -y install clang

# installing cmake
RUN git clone https://github.com/Kitware/CMake.git
RUN cd /CMake && ./bootstrap && make && make install

# vcpkg
RUN dnf -y install perl
RUN git clone https://github.com/microsoft/vcpkg
RUN cd vcpkg && ./bootstrap-vcpkg.sh
RUN cd /vcpkg && ./vcpkg install boost
RUN cd /vcpkg && ./vcpkg install cppkafka
RUN cd /vcpkg && ./vcpkg install gtest
RUN cd /vcpkg && ./vcpkg install spdlog
RUN cd /vcpkg && ./vcpkg install openssl
RUN cd /vcpkg && ./vcpkg install mio
RUN cd /vcpkg && ./vcpkg install libpqxx
RUN cd /vcpkg && ./vcpkg install cxxopts
RUN cd /vcpkg && ./vcpkg install simdjson
RUN cd /vcpkg && ./vcpkg install fmt
RUN cd /vcpkg && ./vcpkg install tl-expected
RUN cd /vcpkg && ./vcpkg install nlohmann-json
RUN cd /vcpkg && ./vcpkg install decimal-for-cpp
RUN cd /vcpkg && ./vcpkg install date
RUN cd /vcpkg && ./vcpkg install pugixml
RUN cd /vcpkg && ./vcpkg install libiconv

RUN echo "alias ll='ls -latr'\n" >> /etc/profile
RUN echo "export PATH='$PATH:/vcpkg'\n" >> /etc/profile

# creating admin
RUN useradd apugachev
RUN usermod apugachev -g root
RUN echo -e "password\npassword" | passwd apugachev
RUN echo "export PATH=$PATH:/vcpkg" >> /home/apugachev/.bash_profile
RUN echo "export VCPKG_CMAKE_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake" >> /home/apugachev/.bash_profile

#cmake -S llvm -B build -DCMAKE_INSTALL_PREFIX=/clang13 -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld'

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]
