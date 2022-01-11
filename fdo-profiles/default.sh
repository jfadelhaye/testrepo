#!/bin/bash -ex

env > env.log

export AGENT_IMAGE=portainer/agent:2.9.3
export GUID=$(cat DEVICE_GUID.txt)
export DEVICE_NAME=$(cat DEVICE_name.txt)
export EDGE_KEY=$(cat DEVICE_edgekey.txt)
export AGENTVOLUME=$(pwd)/data/portainer_agent_data/

mkdir -p ${AGENTVOLUME}

docker pull ${AGENT_IMAGE}

docker run -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes \
    -v /:/host \
    -v ${AGENTVOLUME}:/data \
    --restart always \
    -e EDGE=1 \
    -e EDGE_ID=${GUID} \
    -e EDGE_KEY=${EDGE_KEY} \
    -e CAP_HOST_MANAGEMENT=1 \
    -e EDGE_INSECURE_POLL=1 \
    --name portainer_edge_agent \
    ${AGENT_IMAGE}


