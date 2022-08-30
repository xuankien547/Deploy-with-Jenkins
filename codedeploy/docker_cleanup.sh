#!/bin/bash
cd /home/ec2-user/web/


docker stop $(docker ps -qa) || true
docker system prune -f --volumes || true
