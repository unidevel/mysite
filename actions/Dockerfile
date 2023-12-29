# Ref: https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb
FROM debian:stable-slim

ARG RUNNER_VERSION=2.311.0

ARG RUNNER_ARCH=linux-x64
#ARG RUNNER_ARCH=linux-arm64

#  necessary or when executing installdependencies.sh the container creation will stop
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && useradd -m runner && \
  apt install -y --no-install-recommends \
  curl ca-certificates apt-transport-https jq sudo git ssh && \
  usermod -a -G sudo runner && echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  cat /etc/sudoers
# build-essential libssl-dev libffi-dev \
#  python3 python3-venv python3-dev python3-pip git ssh

RUN cd /home/runner && mkdir actions-runner && cd actions-runner \
  && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz \
  && tar xzf ./actions-runner-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz
RUN chown -R runner:runner ~runner && /home/runner/actions-runner/bin/installdependencies.sh

COPY start.sh start.sh
RUN chmod +x start.sh && mkdir ~runner/.ssh \
  && ssh-keyscan github.com >> ~runner/.ssh/known_hosts \
  && chown -R runner:runner ~runner/.ssh
USER runner
ENTRYPOINT ["./start.sh"]
