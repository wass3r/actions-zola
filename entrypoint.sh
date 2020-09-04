#!/bin/sh -l

echo "downloading zola version: $INPUT_ZOLA_VERSION"
wget -q -O - \
    "https://github.com/getzola/zola/releases/download/${INPUT_ZOLA_VERSION}/zola-${INPUT_ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
    | tar xzf - -C /usr/local/bin

echo "building site"
zola build
