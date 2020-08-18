FROM debian:buster-slim
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install 'python-language-server[all]'
RUN adduser --quiet langserver
USER langserver
ENTRYPOINT /usr/local/bin/pyls
