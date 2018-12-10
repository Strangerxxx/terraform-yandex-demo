resource "yandex_compute_instance" "demo" {
  name        = "demo"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.debian.id}"
      size = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.phobia-a.id}"
    nat = true
  }

  metadata {
    user_data = "${data.template_file.init.rendered}"
  }
  provisioner "remote-exec" {
    inline = [
      "whoami"
    ]
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.ssh-keys[0]}"
    }
  }
  provisioner "remote-exec" {
    scripts = "${var.setup-scripts}"
    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${var.ssh-keys[0]}"
    }
  }
}
