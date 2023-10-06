# Use the official image as a parent image.
FROM clickhouse-server:latest

ENV container docker

# Set the working directory.
WORKDIR /

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

RUN apt update
RUN apt -y install vim

RUN clickhouse start

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]
