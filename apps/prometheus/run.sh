#!/bin/bash
docker run -d --restart unless-stopped -p 9090:9090 \
        --mount type=bind,src=/srv/etc/prometheus,dst=/etc/prometheus,readonly \
        --mount type=bind,src=/srv/data/prometheus,dst=/prometheus \
        --name myprometheus \
	prom/prometheus

