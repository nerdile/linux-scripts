#!/bin/bash
docker run -d --restart unless-stopped -p 80:80 -p 443:443 \
        --mount type=bind,src=/srv/data/nginx/html,dst=/usr/share/nginx/html,readonly \
        --mount type=bind,src=/srv/etc/nginx,dst=/etc/nginx,readonly \
        --name mynginx \
        nginx

