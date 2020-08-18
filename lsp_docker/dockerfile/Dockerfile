FROM debian:buster-slim
RUN apt-get update && apt-get install -y npm
RUN npm install -g dockerfile-language-server-nodejs
RUN adduser --quiet langserver
USER langserver
ENTRYPOINT /usr/local/bin/docker-langserver --stdio
