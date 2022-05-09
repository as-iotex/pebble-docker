# Base image which contains global dependencies
FROM ubuntu:20.04 as base

# System dependencies
ARG arch=amd64
RUN mkdir /project && \
    mkdir /.cache && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        wget \
        python3-pip \
        ninja-build \
        gperf \
        git \
        unzip \
        python3-setuptools \
        libncurses5 libncurses5-dev \
        libyaml-dev libfdt1 \
        libusb-1.0-0-dev udev \
        device-tree-compiler=1.5.1-1 \
        ruby && \
    apt-get -y clean && apt-get -y autoremove && \

    # Nordic command line tools
    # Releases: https://www.nordicsemi.com/Software-and-tools/Development-Tools/nRF-Command-Line-Tools/Download
    # Doesn't exist for arm64, but not necessary for building
    if [ ! -z "$NCLT_URL" ]; then \
        mkdir tmp && cd tmp && \
        wget -q "${NCLT_URL}" && \
        unzip nrf-command-line-tools-*.zip && \
        tar xzf nrf-command-line-tools-*.tar.gz && \
        dpkg -i *.deb && \
        cd .. && rm -rf tmp ; \
    else \
        echo "Skipping nRF Command Line Tools (not available for $arch)" ; \
    fi && \

    # GCC ARM Embed Toolchain
    wget -q https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 && \
    tar -jxvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2 && \
    mv gcc-arm-none-eabi-9-2020-q2-update  ~/gnuarmemb && \
    echo 'export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb' >> ~/.zephyrrc  && \
    echo 'export GNUARMEMB_TOOLCHAIN_PATH="~/gnuarmemb"' >> ~/.zephyrrc && \

    # Latest PIP & Python dependencies
    python3 -m pip install -U pip && \
    python3 -m pip install -U setuptools && \
    python3 -m pip install 'cmake>=3.20.0' wheel && \
    python3 -m pip install -U west==0.12.0 && \
    python3 -m pip install -U nrfutil && \
    python3 -m pip install pc_ble_driver_py && \

    # Newer PIP will not overwrite distutils, so upgrade PyYAML manually
    python3 -m pip install --ignore-installed -U PyYAML

    # ClangFormat
    # python3 -m pip install -U six && \
    # apt-get -y install clang-format-9 && \
    # ln -s /usr/bin/clang-format-9 /usr/bin/clang-format && \
    # wget -qO- https://raw.githubusercontent.com/nrfconnect/sdk-nrf/main/.clang-format > /.clang-format

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
ENV GNUARMEMB_TOOLCHAIN_PATH=~/gnuarmemb