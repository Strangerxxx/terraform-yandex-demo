  - address: ${nat_ip}
    internal_address: ${int_ip}
    user: ${user}
    role:
      - controlplane
      - etcd
      - worker