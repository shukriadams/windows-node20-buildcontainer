set -e
DOCKERPUSH=0
SMOKETEST=0

while [ -n "$1" ]; do 
    case "$1" in
    --dockerpush|-p) DOCKERPUSH=1 ;;
    --smoketest|-t) SMOKETEST=1 ;;
    esac 
    shift
done

docker build -t shukriadams/windows-node20-build .
echo "container built"

if [ $DOCKERPUSH -eq 1 ]; then
    echo "starting docker push"
    TAG=$(git describe --tags --abbrev=0) 
    if [ -z "$TAG" ]; then
        echo "TAG not set, exiting"
        exit 1;
    fi    
    echo "Tag ${TAG} detected"
    
    docker tag shukriadams/windows-node20-build:latest shukriadams/windows-node20-build:$TAG 
    docker login -u $DOCKER_USER -p $DOCKER_PASS 
    docker push shukriadams/windows-node20-build:$TAG 
    echo "container push complete"
fi

echo "build complete"
