#cloud-config
datasource:
 Ec2:
  strict_id: false
ssh_pwauth: no
users:
- name: ${user}
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh-authorized-keys:
${keys}