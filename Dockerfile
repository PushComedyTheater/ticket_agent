FROM ubuntu:16.04

# Avoid error messages from apt during image build
ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y wget curl

RUN \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  apt-get update && \
  apt-get install -y esl-erlang elixir build-essential openssh-server git locales

RUN \
  apt-get update && \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install -y nodejs

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=$LANG

RUN mkdir /var/run/sshd

# Create pushers user
RUN useradd --system --shell=/bin/bash --create-home pushers

#config pushers user for public key authentication
RUN mkdir /home/pushers/.ssh/ && chmod 700 /home/pushers/.ssh/
COPY ./config/ssh_key.pub /home/pushers/.ssh/authorized_keys
RUN chown -R pushers /home/pushers/
RUN chgrp -R pushers /home/pushers/
RUN chmod 700 /home/pushers/.ssh/
RUN chmod 644 /home/pushers/.ssh/authorized_keys

RUN mix local.hex --force
RUN mix local.rebar --force

#Configure public keys for sshd
RUN  echo "AuthorizedKeysFile  %h/.ssh/authorized_keys" >> /etc/ssh/sshd_config

RUN mkdir -p /home/pushers/config
COPY apps/ticket_agent_web/config/prod.secret.exs /home/pushers/config/prod.secret.exs

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
