#!/bin/bash
cd /home/ec2-user/web/ 
docker-compose -f docker-compose.yml up -d --build
