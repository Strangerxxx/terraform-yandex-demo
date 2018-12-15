resource "yandex_compute_instance" "master" {
  name        = "master-${count.index}"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  count    = "${var.master_count}"

  resources {
    cores  = 4
    memory = 16
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.debian.id}"
      size = 20
      type_id = "network-nvme"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.a.id}"
    nat = true
  }

  metadata {
    user-data = "${data.template_file.init.rendered}"
  }

  provisioner "remote-exec" {
    scripts = "${var.master_scripts}"

    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${tls_private_key.ssh-key.private_key_pem}"
    }
  }
}
resource "yandex_compute_instance" "worker" {
  name        = "worker-${count.index}"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  count    = "${var.worker_count}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.debian.id}"
      size = 20
      type_id = "network-nvme"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.a.id}"
    nat = true
  }

  metadata {
    user-data = "${data.template_file.init.rendered}"
  }

  provisioner "remote-exec" {
    scripts = "${var.worker_scripts}"

    connection {
      type        = "ssh"
      user        = "${var.username}"
      private_key = "${tls_private_key.ssh-key.private_key_pem}"
    }
  }
}