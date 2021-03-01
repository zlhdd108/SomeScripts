FROM ubuntu:latest
LABEL VERSION=1.0

RUN set -ex \
        && apt-get update && apt-get upgrade \
        && apt-get install -y tzdata moreutils git nodejs npm curl jq python-pip \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && pip install --upgrade pip \
        && echo "Asia/Shanghai" > /etc/timezone

# 配置镜像仓库配置相关文件夹
# 创建工作目录
RUN mkdir /logs \
        && mkdir /pss \
        && cd  /pss \
        && git init \
        && git remote add -f origin https://github.com/FKPYW/SomeScripts.git \
        && git config core.sparsecheckout true \
        && echo AutoCheckin/* >> /pss/.git/info/sparse-checkout \
        && git pull origin master \
        && cp /pss/AutoCheckin/crontab_list.sh /pss/crontab_list.sh

# CloudMusic
RUN git clone https://github.com/t00t00-crypto/wyy-action.git /CloudMusic \
        && cd /CloudMusic \
        && git checkout master \
        && pip install -r requirements.txt

# smzdm
RUN git clone https://github.com/jiegto/Actions_smzdm.git /smzdm \
        && cd /smzdm \
        && git checkout main \
        && npm install

# Cloud189
RUN git clone https://github.com/qkqpttgf/Cloud189Checkin-Actions.git /Cloud189 \
        && cd /Cloud189 \
        && git checkout main \
        && pip install -r requirements.txt

# Github Action 构建
COPY ./AutoCheckin/docker_entrypoint.sh /usr/local/bin/
# 本地构建
# COPY ./crontab_list.sh ./default_task.sh /pss/
#COPY ./docker_entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker_entrypoint.sh \
        &&  crontab /pss/crontab_list.sh

#镜像构建版本,每次调整构建文件更新
ENV BUILD_VERSION=1.0 \
        DEFAULT_LIST_FILE=crontab_list.sh \
        CUSTOM_LIST_MERGE_TYPE=append 

ENTRYPOINT ["docker_entrypoint.sh"]
