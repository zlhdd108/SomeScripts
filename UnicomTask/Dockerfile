FROM alpine
LABEL VERSION=1.0

ENV DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache tzdata git moreutils python3 py3-pip jq curl \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /logs \
        && mkdir /pss \
        && cd /pss \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts \
        && git config core.sparsecheckout true \
        && echo UnicomTask >> /pss/.git/info/sparse-checkout \
        && git pull origin master --rebase

RUN cp /pss/UnicomTask/docker_entrypoint.sh /usr/local/bin \
        && chmod +x /usr/local/bin/docker_entrypoint.sh

ENTRYPOINT ["docker_entrypoint.sh"]

CMD [ "crond" ]
