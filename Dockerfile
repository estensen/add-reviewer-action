FROM debian:9.6-slim

RUN apt-get update && apt-get install -y \
    curl \
    jq

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
