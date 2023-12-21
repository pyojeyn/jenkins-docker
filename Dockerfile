FROM jenkins/jenkins:lts

USER root
## 최종으로 도커 24.0.6으로 설치 성공.
# Install Docker
ARG DOCKER_VERSION=24.0.7
RUN mkdir -p /tmp/docker && \
    curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o docker.tgz && \
    tar --extract --file docker.tgz --strip-components 1 --directory /tmp/docker && \
    mv /tmp/docker/* /usr/local/bin/ && \
    rm docker.tgz && \
    groupadd -g 1001 docker && \
    usermod -aG docker jenkins

# Add Jenkins user to the Docker group if not already a member
# RUN DOCKER_GID=$(getent group docker | cut -d: -f3) && \
#     groupadd -g $DOCKER_GID docker || true && \
#     usermod -aG docker jenkins

USER jenkins

##12/20 기록 
## 이렇게 하면 docker에 접속은 할 수 있지만. docker-hub 의 접근 이슈에서 막혔다. 