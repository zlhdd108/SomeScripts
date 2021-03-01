FROM alpine
LABEL VERSION=1.0

RUN set -ex \
        && apk update && apk upgrade \
        && apk add --no-cache python3 py3-pip tzdata moreutils git curl jq\
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

# 配置镜像仓库配置相关文件夹
# 创建工作目录
RUN mkdir /logs \
        && mkdir /AutomationTTnode \
        && mkdir /pss \
        && cd  /pss \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo AutomationTTnode/* >> /pss/.git/info/sparse-checkout \
        && git pull origin master \
        && cp /pss/AutomationTTnode/crontab_list.sh /pss/crontab_list.sh
        
# Github Action 构建
COPY ./AutomationTTnode/docker_entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker_entrypoint.sh \
        &&  crontab /pss/crontab_list.sh

WORKDIR /AutomationTTnode

#镜像构建版本,每次调整构建文件更新
ENV BUILD_VERSION=1.0 \
        DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append

ENTRYPOINT ["docker_entrypoint.sh"]