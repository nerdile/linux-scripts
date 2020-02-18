#!/bin/bash
docker run -d --restart unless-stopped -p 3000:3000 \
        --mount type=bind,src=/srv/data/grafana,dst=/var/lib/grafana \
        --mount type=bind,src=/srv/etc/grafana/grafana.ini,dst=/etc/grafana/grafana.ini:readonly \
        --name mygrafana \
        grafana/grafana

