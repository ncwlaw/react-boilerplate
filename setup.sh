if [ -z "$1" ]; then
  echo "Target container name not supplied"
  exit 1
fi

docker build \
  --build-arg USER_ID=$UID \
  --build-arg GROUP_ID=$UID \
  -t $1 \
  -f Dockerfile.setup \
  .
