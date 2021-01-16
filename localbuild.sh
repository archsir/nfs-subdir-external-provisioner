docker buildx build --build-arg APP_FOLDER=/build \
  --tag snapshots.docker.sunnywith.com/external_storage/nfs-client-provisioner:21.01.17 \
  --platform linux/amd64 --file ./Dockerfile.multiarch --push .
