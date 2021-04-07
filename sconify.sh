#!/bin/bash
set -e
# we usually run Kubernetes and this won't be necessary, 
# but for this example we will use local LAS service.
source run_las.sh

echo "Start sconification..."
# we ues && to ensure that all commands finish before run next one
docker run -it --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --device=/dev/isgx \
            --network=host \
        registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-scone5.3.0 sconify_image \
            --name=c_session_name \
            --from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c \
            --to=hello-world-c-scone \
            --service-name=c-service \
            --cas="5-2-0.scone-cas.cf" \
            --cas-debug \
            --create-namespace \
            --las="localhost" \
            --cli="registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-scone5.3.0" \
            --crosscompiler="registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-scone5.3.0" \
            --binary-fs \
            --binary="/app/hello-world" \
            --fs-dir=/app \
            --heap="64M" \
            --dlopen="2" \
            --no-color \
            --command="/app/hello-world"
start_las && \
echo "Run sconified image..." && \
docker run -it --rm  --network=host --device=/dev/isgx -eSCONE_VERSION=1 hello-world-c-scone && \
stop_las
