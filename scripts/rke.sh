#!/usr/bin/env bash
if [[ ! -e bin/rke ]]; then
    mkdir -p bin
    curl https://github.com/rancher/rke/releases/download/v0.1.13/rke -o bin/rke
    chmod +x bin/rke
fi
if [[ ! -z $1 ]]; then
    bin/rke up --config $1
fi
