FROM alpine:latest

RUN	apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  wget \
  jq

COPY download_release_assets.sh /download_release_assets.sh
RUN chmod +x /download_release_assets.sh


ENTRYPOINT ["/downloadassets.sh"]