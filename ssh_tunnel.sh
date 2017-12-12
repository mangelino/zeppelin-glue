#!/bin/bash

ssh-keyscan $DEV_ENDPOINT >> /root/.ssh/known_hosts

ssh -i /ssh/ssh.key -NL 127.0.0.1:9007:169.254.76.1:9007 glue@$DEV_ENDPOINT & /zeppelin/bin/zeppelin.sh