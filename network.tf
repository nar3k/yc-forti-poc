
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

resource "yandex_vpc_subnet" "router-subnet-a" {
  count          = "2"
  name           = "${yandex_vpc_network.network-a.name}-router-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network-a.id}"
  v4_cidr_blocks = ["10.100.${count.index}.0/24"]
}

resource "yandex_vpc_subnet" "user-subnet-a" {
  count          = "2"
  name           = "${yandex_vpc_network.network-a.name}-user-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network-a.id}"
  v4_cidr_blocks = ["10.10.${count.index}.0/24"]
}


resource "yandex_vpc_network" "network-b" {
  name = "network-b"
}

resource "yandex_vpc_subnet" "router-subnet-b" {
  count          = "2"
  name           = "${yandex_vpc_network.network-b.name}-router-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network-b.id}"
  v4_cidr_blocks = ["10.101.${count.index}.0/24"]
}

resource "yandex_vpc_subnet" "user-subnet-b" {
  count          = "2"
  name           = "${yandex_vpc_network.network-b.name}-user-${count.index}"
  zone           = "${element(var.zones,count.index)}"
  network_id     = "${yandex_vpc_network.network-b.id}"
  v4_cidr_blocks = ["10.11.${count.index}.0/24"]
}

locals {
  intersubnet_ids = ["${yandex_vpc_subnet.intersubnet.*.id}"]
  router_subnet_a_ids = ["${yandex_vpc_subnet.router-subnet-a.*.id}"]
  router_subnet_b_ids = ["${yandex_vpc_subnet.router-subnet-b.*.id}"]
  user_subnet_a_ids = ["${yandex_vpc_subnet.user-subnet-a.*.id}"]
  user_subnet_b_ids = ["${yandex_vpc_subnet.user-subnet-b.*.id}"]
}
