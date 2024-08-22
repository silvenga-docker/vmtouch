FROM debian:bullseye AS builder

RUN set -xe \
    && apt-get update \
    && apt-get install -y git build-essential \
    && mkdir /source \
    && cd /source \
    && git clone https://github.com/hoytech/vmtouch.git . \
    && make vmtouch

FROM debian:bullseye

LABEL maintainer="Mark Lopez <m@silvenga.com>"

COPY --from=builder /source/vmtouch /bin/vmtouch

ENTRYPOINT [ "vmtouch" ]
