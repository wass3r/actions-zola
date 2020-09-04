# Container image that runs your code
FROM debian:buster-slim

LABEL repository="https://github.com/wass3r/actions-zola"
LABEL homepage="https://github.com/wass3r/actions-zola"

LABEL "com.github.actions.name"="actions-zola"
LABEL "com.github.actions.description"="create static sites with zola"
LABEL "com.github.actions.icon"="book"
LABEL "com.github.actions.color"="blue"

RUN apt-get update && apt-get install -y wget

COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]