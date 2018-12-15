resource "yandex_vpc_network" "net" {
  name = "${var.cluster_name}"
  description = "net VPC"
}
resource "yandex_vpc_subnet" "a" {
  name           = "${var.cluster_name}-a"
  v4_cidr_blocks = ["10.1.0.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.net.id}"
}
resource "yandex_vpc_subnet" "b" {
  name           = "${var.cluster_name}-b"
  v4_cidr_blocks = ["10.2.0.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.net.id}"
}
resource "yandex_vpc_subnet" "c" {
  name           = "${var.cluster_name}-c"
  v4_cidr_blocks = ["10.3.0.0/24"]
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.net.id}"
}