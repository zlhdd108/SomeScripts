FROM alpine
LABEL VERSION=1.1

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache python3 py3-pip tzdata moreutils git curl jq \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

# 配置镜像仓库配置相关文件夹
# 创建工作目录
RUN mkdir /logs \
        && mkdir /scripts \
        && cd /scripts \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo UnicomTask/* >> /scripts/.git/info/sparse-checkout \
        && git pull origin master \
        && cp /scripts/UnicomTask/docker_entrypoint.sh /usr/local/bin \
        && chmod +x /usr/local/bin/docker_entrypoint.sh

RUN mkdir /UnicomTask \
        && cd /UnicomTask \
        && git init \
        && git remote add -f origin https://github.com/srcrs/UnicomTask \
        && git config core.sparsecheckout true \
        && echo *.py >> /UnicomTask/.git/info/sparse-checkout \
        && echo requirements.txt >> /UnicomTask/.git/info/sparse-checkout \
        && git pull origin main \
        && pip3 install --upgrade pip \
        && pip3 install -r requirements.txt

WORKDIR /UnicomTask

#镜像构建版本,每次调整构建文件更新
ENV BUILD_VERSION=1.1 \
        DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append

ENTRYPOINT ["docker_entrypoint.sh"]

CMD [ "crond" ]