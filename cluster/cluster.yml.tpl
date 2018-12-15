cluster_name: ${cluster}
ignore_docker_version: true
ssh_key_path: ${private_key}
ssh_agent_auth: false
kubernetes_version: v1.12.3-rancher1-1

nodes:
${master_nodes}
${worker_nodes}

network:
    plugin: canal

ingress:
    provider: none