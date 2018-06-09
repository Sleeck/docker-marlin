FROM debian:latest

MAINTAINER Sleeck <contact@sleeck.eu>
LABEL description="Marlin is a Siacoin Stratum miner for OpenCL and CUDA devices developed by https://siamining.com. It is designed to be fast, lightweight and easy to use."

WORKDIR /tmp

RUN apt-get update \
    && apt-get -y --no-install-recommends install ca-certificates curl ocl-icd-opencl-dev\
    && curl -L $(curl --silent "https://api.github.com/repos/SiaMining/marlin/releases/latest" | grep -Po '"browser_download_url": "\K.*?(?=")' | grep amd64) -o marlin.tar.gz \
    && tar -xvf marlin.tar.gz \
    && rm marlin.tar.gz \
    && mv marlin /usr/local/bin/marlin \
    && chmod a+x /usr/local/bin/marlin \
    && apt-get -y remove ca-certificates curl \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{log,dpkg,apt,cache}

ENTRYPOINT ["marlin"]
CMD ["-h"]