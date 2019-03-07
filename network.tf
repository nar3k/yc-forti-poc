
resource "yandex_vpc_network" "internetwork" {
  name = "internetwork"
}

resource "yandex_vpc_subnet" "intersubnet" {
  count          = "2"
  name           = "${yandex_vpc_network.internetwork.name}-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.internetwork.id}"
  v4_cidr_blocks = ["10.250.${count.index}.0/24"]
}

resource "yandex_vpc_network" "network-a" {
  name = "network-a"
}

resource "yandex_vpc_subnet" "subnet-a" {
  count          = "2"
  name           = "${yandex_vpc_network.network-a.name}-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network-a.id}"
  v4_cidr_blocks = ["10.100.${count.index}.0/24"]
}

resource "yandex_vpc_network" "network-b" {
  name = "network-b"
}

resource "yandex_vpc_subnet" "subnet-b" {
  count          = "2"
  name           = "${yandex_vpc_network.network-b.name}-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network-b.id}"
  v4_cidr_blocks = ["10.200.${count.index}.0/24"]
}

locals {
  intersubnet_ids = ["${yandex_vpc_subnet.intersubnet.*.id}"]
  subnet_a_ids = ["${yandex_vpc_subnet.subnet-a.*.id}"]
  subnet_b_ids = ["${yandex_vpc_subnet.subnet-b.*.id}"]
}
