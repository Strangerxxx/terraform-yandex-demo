data "template_file" "init" {
  template = "${file("data/userdata.tpl")}"
  vars {
    username = "${var.username}"
    public_key = "${tls_private_key.ssh-key.public_key_openssh}"
  }
}