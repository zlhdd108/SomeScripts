FROM alpine
LABEL VERSION=1.1

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache tzdata moreutils yarn git nodejs curl jq \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN git clone https://github.com/troyeguo/koodo-reader.git /koodo \
        && cd /koodo \
        && git checkout master \
        && yarn

# Github Action 构建
COPY ./Koodo-Reader/docker_entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker_entrypoint.sh

WORKDIR /koodo

ENTRYPOINT ["docker_entrypoint.sh"]
