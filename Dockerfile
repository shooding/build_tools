FROM ubuntu:16.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update the sources.list to use the mirror closet to you
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://free.nchc.org.tw/ubuntu/|g' /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install python \
                                    python3 \
                                    sudo \
                                    openjdk-11-jdk \
                                    openjdk-11-jdk-headless \
                                    openjdk-11-jre \
                                    openjdk-11-jre-headless \
                                    git \
                                    openssh-client

RUN rm /usr/bin/python && ln -s /usr/bin/python2 /usr/bin/python

# Declare the volume to share with host machine. Mount -v /path/from/host:/work
# ├── build_tools
# ├── core
# ├── core-fonts
# ├── dictionaries
# ├── qt-everywhere-opensource-src-5.9.9 (pre download and tar -xf )
# ├── sdkjs
# ├── server
# ├── web-apps
# ├── document-server-integration
# ├── ...
VOLUME ["/work"]
WORKDIR /work

# Set the default command
CMD ["bash"]
