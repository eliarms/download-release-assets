FROM alpine:latest

RUN	apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  wget \
  jq

COPY downloadassets.sh /downloadassets.sh
RUN chmod +x /downloadassets.sh


ENTRYPOINT ["/downloadassets.sh"]