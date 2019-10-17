#!/bin/bash

# usage:
# $0 staging
# $0 production

deploy() {
  local user=$1
  local host=$2
  # local port=$3
  shift 3
  local cmd="$@"
  ssh_args="-A -o StrictHostKeyChecking=no -p $port $user@$host"
  echo $cmd | ssh $ssh_args 'bash -l -s'
}

env=${1:-'staging'}
echo
echo "Deploying to $env ..."

if [ $env = 'staging' ]; then
  host=$VPS_HOST
  port=6789
  user=$VPS_USER
  cmd="cd /home/deploy/docker && ./bin/docker_build.sh /home/deploy/docker_build/online_blogs staging && ./bin/docker_restart.sh online_blogs staging"
  deploy $user $host $port $cmd
else
  host=$VPS_HOST
  # port=6789
  user=$VPS_USER
  cmd="cd /home/deploy/docker && ./bin/docker_build.sh /home/deploy/docker_build/online_blogs production && ./bin/remote_restart.sh online_blogs production"
  deploy $user $host $cmd
fi
