
#!/bin/sh -l

ZOLA_VERSION=$1

cd /actions-zola
echo "creating zola image using zola version: $ZOLA_VERSION"

# here we can make the construction of the image as customizable as we need
# and if we need parameterizable values it is a matter of sending them as inputs
docker build -t actions-zola --build-arg zola_version="$ZOLA_VERSION" . && docker run actions-zola