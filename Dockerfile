FROM jenkins/jenkins:lts

USER root

# Install Docker
ARG DOCKER_VERSION=24.0.6
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o docker.tgz && \
    tar -xz -C /tmp -f docker.tgz && \
    mv /tmp/docker/* /usr/local/bin/ && \
    rm -rf /tmp/docker* && \
    usermod -aG docker jenkins

# Add Jenkins user to the Docker group if not already a member
RUN DOCKER_GID=$(getent group docker | cut -d: -f3) && \
