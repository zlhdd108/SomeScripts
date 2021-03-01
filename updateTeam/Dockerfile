FROM alpine
LABEL AUTHOR="none" \
        VERSION=0.0.1

ENV DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache tzdata git nodejs moreutils npm curl jq openssh-client \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && mkdir -p /root/.ssh \
        && touch /root/.ssh/id_rsa \
        && chmod 600 /root/.ssh/id_rsa \
        && ssh-keyscan github.com > /root/.ssh/known_hosts

RUN mkdir /jds \
        && mkdir /logs \
        && cd /jds \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo updateTeam >> /jds/.git/info/sparse-checkout \
        && git pull origin master --rebase \
        && cd /jds/js \
        && npm install
        
RUN mkdir /updateTeam

RUN cp /jds/updateTeam/docker_entrypoint.sh /usr/local/bin \
        && chmod +x /usr/local/bin/docker_entrypoint.sh

WORKDIR /scripts

ENTRYPOINT ["docker_entrypoint.sh"]

CMD [ "crond" ]