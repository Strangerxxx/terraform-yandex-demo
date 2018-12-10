resource "yandex_vpc_network" "phobia" {
  name = "phobia"
  description = "Phobia VPC"
}
resource "yandex_vpc_subnet" "phobia-a" {
  name           = "phobia-a"
  v4_cidr_blocks = ["10.1.0.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.phobia.id}"
}
resource "yandex_vpc_subnet" "phobia-b" {
  name           = "phobia-b"
  v4_cidr_blocks = ["10.2.0.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.phobia.id}"
}
resource "yandex_vpc_subnet" "phobia-c" {
  name           = "phobia-c"
  v4_cidr_blocks = ["10.3.0.0/24"]
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.phobia.id}"
}