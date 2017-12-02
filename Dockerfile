FROM debian:latest

RUN apt-get update && apt-get install -y \
    libc6-dev \
    git \
    make \ 
    cmake \
    gcc \ 
    libjson-c-dev \
     && rm -rf /var/lib/apt/lists/*

RUN git clone http://git.openwrt.org/project/libubox.git /opt/libubox &&\
    ln -s /usr/include/json-c/ /usr/include/json &&\
    cd /opt/libubox &&\
    cmake -DBUILD_LUA=OFF -DBUILD_EXAMPLES=OFF . &&\
    make &&\
    make install

RUN git clone http://git.openwrt.org/project/uci.git /opt/uci &&\
    cd /opt/uci &&\
    cmake -DBUILD_LUA=OFF . &&\
    make &&\
    make install

RUN git clone https://github.com/alexbeltran/bacnet-stack.git /opt/bacnet-stack &&\
    cd /opt/bacnet-stack &&\
    make BACNET_PORT=linux BUILD=debug BACDL_DEFINE="-DBACDL_BIP=1" \
    BACNET_DEFINES="-I/opt/local/include -DBAC_UCI -DBACAPP_ALL -DBACNET_PROPERTY_LISTS -DINTRINSIC_REPORTING -DAI -DAO -DAV -DBI -DBO -DBV -DMSI -DMSO -DMSV -DTRENDLOG"\
     UCI_LIB_DIR=/usr/local/lib

RUN mkdir -p /etc/config
COPY config/bacnet_av /etc/config/
COPY config/bacnet_bv /etc/config/
COPY config/bacnet_dev /etc/config/
COPY config/bacnet_nc /etc/config/
COPY config/bacnet_mv /etc/config/
COPY config/bacnet_tl /etc/config/
    
ENV PATH /opt/bacnet-stack/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/lib

EXPOSE 47808/udp
CMD ["bacserv", "1234"]
