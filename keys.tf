resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
output "private-key" {
  value = "${tls_private_key.ssh-key.private_key_pem}"
}