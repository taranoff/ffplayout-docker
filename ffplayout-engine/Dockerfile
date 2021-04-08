FROM python:3-alpine

ARG version=3.1.0

RUN pip install supervisor

# get ffplayout engine and install all dependencies
RUN cd /opt && \
    wget "https://github.com/ffplayout/ffplayout-engine/archive/v${version}.zip" && \
    unzip "v${version}.zip" && \
    mv "ffplayout-engine-${version}" 'ffplayout-engine' && \
    rm "v${version}.zip" && \
    cd ffplayout-engine && \
    pip install --no-cache-dir -r requirements-base.txt && \
    mkdir /etc/ffplayout

# install build tools, ffmpeg dependencies and compile ffmpeg
RUN apk update && \
    apk add --no-cache build-base gcc libtool gperf nasm yasm linux-headers tzdata openssl-dev && \
    apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
        expat-dev zlib-dev fontconfig-dev libxml2-dev lame-dev \
        libpng-dev fribidi-dev zeromq-dev freetype-dev opus-dev && \
    apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
        gnu-libiconv fdk-aac-dev libass-dev libvpx-dev libsrt-dev x264-dev x265-dev && \
    # psutil needs gcc
    pip install --no-cache-dir psutil && \
    cd /opt && \
    wget "https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2" && \
    tar xfvj ffmpeg-snapshot.tar.bz2 && \
    rm ffmpeg-snapshot.tar.bz2 && \
    cd ffmpeg && \
    ./configure --prefix='/usr/local/' --enable-pthreads --extra-libs=-lpthread \
    --disable-debug --disable-doc --enable-gpl --enable-version3 \
    --enable-nonfree --enable-runtime-cpudetect --enable-fontconfig \
    --enable-openssl --enable-libass --enable-libfdk-aac --enable-libfreetype \
    --enable-libfribidi --enable-libmp3lame --enable-libopus --enable-libvpx \
    --enable-libsrt --enable-libx264 --enable-libx265 --enable-libzmq && \
    make -j $(nproc | awk '{print $1 / 2}') && \
    make install && \
    cd .. && \
    rm -rf ffmpeg && \
    # cleanup
    apk del build-base gcc libtool gperf nasm yasm

WORKDIR /opt/ffplayout-engine
EXPOSE 5555 9001

CMD ["/usr/local/bin/supervisord", "-c", "/etc/ffplayout/supervisor/supervisord.conf"]
