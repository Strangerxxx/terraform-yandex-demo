#!/usr/bin/env bash
if [[ ! -e bin/rke ]]; then
    mkdir -p bin
    arch=$(uname -s)
    if [[ $arch = "Darwin" ]]; then
        curl -L https://github.com/rancher/rke/releases/download/v0.1.13/rke_darwin-amd64 -o bin/rke
    elif [[ "$arch" = "Linux" ]]; then
        curl -L https://github.com/rancher/rke/releases/download/v0.1.13/rke_linux-amd64 -o bin/rke
    else
        #curl -L https://github.com/rancher/rke/releases/download/v0.1.13/rke -o bin/rke
        echo "Platform is not supported: $arch"
        exit 1
    fi
    chmod +x bin/rke
fi
if [[ ! -z $1 ]]; then
    echo "rke ${@:2} --config $1"
    bin/rke ${@:2} --config $1
fi
