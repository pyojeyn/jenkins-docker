FROM jenkins/jenkins:lts

USER root

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

# Add Jenkins user to the Docker group if not already a member
RUN DOCKER_GID=$(getent group docker | cut -d: -f3) && \
    groupadd -g $DOCKER_GID docker || true && \
    usermod -aG docker jenkins

USER jenkins