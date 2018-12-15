  - address: ${nat_ip}
    hostname_override: ${name}
    internal_address: ${int_ip}
    user: ${user}
    role:
      - controlplane
      - etcd
      - worker