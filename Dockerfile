FROM debian:bookworm-slim
MAINTAINER hbattat@gmail.com

ENV DEBIANFRONTEND=noninteractive
ARG IVENTOY_VERSION=1.0.20

RUN apt update -y && apt install -y --no-install-recommends jq curl supervisor libglib2.0-dev libevent-dev libwim-dev

RUN curl -kL https://github.com/ventoy/PXE/releases/download/v${IVENTOY_VERSION}/iventoy-${IVENTOY_VERSION}-linux-free.tar.gz -o /tmp/iventoy.tar.gz && \
    tar -xvzf /tmp/iventoy.tar.gz -C / && \
    mv /iventoy-${IVENTOY_VERSION} /iventoy && \
    mkdir -p /var/log/supervisor

COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/run.sh /run.sh

VOLUME /iventoy/iso /iventoy/data /iventoy/log /iventoy/user

RUN ln -sf /proc/1/fd/1 /iventoy/log/log.txt

EXPOSE 26000 16000 10809 69/udp
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
