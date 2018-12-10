data "template_file" "init" {
  template = "${file("data/init.tpl")}"
  vars = {
    user = "${var.username}"
    keys = "${join("\n", formatlist("  - %s", var.ssh-keys))}"
  }
}