FROM alpine:3.12.0

MAINTAINER Matt Kunkel "matt@mrkunkel.com"

RUN apk --no-cache add -f bind-tools coreutils curl openssl

ADD startup /usr/local/bin/startup
RUN chmod 700 /usr/local/bin/startup && \
    mkdir -p /certs && \
    curl https://get.acme.sh | sh

ENV AWS_REGION us-west-2
ENV AWS_ACCESS_KEY_ID abc123
ENV AWS_SECRET_ACCESS_KEY abc123
ENV AWS_DNS_SLOWRATE 1
ENV ACME_RELOAD sleep 1
ENV ACME_DOMAIN example.com

WORKDIR /certs
CMD /usr/local/bin/startup
