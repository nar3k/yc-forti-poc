provider "yandex" {
  token     = "${var.token}"
  cloud_id  = "${var.cloud_id}"
  folder_id = "${var.folder_id}"
}


resource "yandex_compute_instance" "router_a" {
  count       = "2"
  name        = "router-a-${count.index}"
  hostname    = "router-a-${count.index}"
  description = "router-a-${count.index}"
  zone = "${element(var.zones, count.index)}"

  resources {
    cores  = "1"
    memory = "1"
  }

  boot_disk {
    initialize_params {
      image_id = "${var.router_image_id}"
      type_id = "network-nvme"
      size = "31"
    }
  }


  network_interface {
    subnet_id = "${element(local.intersubnet_ids, count.index)}"
    nat       = true
  }
  network_interface {
    subnet_id = "${element(local.router_subnet_a_ids, count.index)}"
  }


}



resource "yandex_compute_instance" "router_b" {
  count       = "2"
  name        = "router-b-${count.index}"
  hostname    = "router-b-${count.index}"
  description = "router-b-${count.index}"
  zone = "${element(var.zones, count.index)}"

  resources {
    cores  = "1"
    memory = "1"
  }

  boot_disk {
    initialize_params {
      image_id = "${var.router_image_id}"
      type_id = "network-nvme"
      size = "31"
    }
  }


  network_interface {
    subnet_id = "${element(local.intersubnet_ids, count.index)}"
    nat       = true
  }
  network_interface {
    subnet_id = "${element(local.router_subnet_b_ids, count.index)}"
  }
}
