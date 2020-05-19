FROM debian:stretch-slim
ARG zola_version

LABEL repository="https://github.com/wass3r/actions-zola"
LABEL homepage="https://github.com/wass3r/actions-zola"

LABEL "com.github.actions.name"="actions-zola"
LABEL "com.github.actions.description"="create static sites with zola"
LABEL "com.github.actions.icon"="book"
LABEL "com.github.actions.color"="blue"

RUN apt-get update && apt-get install -y wget

RUN wget -q -O - \
    "https://github.com/getzola/zola/releases/download/${zola_version}/zola-${zola_version}-x86_64-unknown-linux-gnu.tar.gz" \
    | tar xzf - -C /usr/local/bin

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
