
data "yandex_compute_image" "base_image" {
  family = "centos-7"
}


resource "yandex_compute_instance" "slave_a" {
  count       = "2"
  name        = "slave-a-${count.index}"
  hostname    = "slave-a-${count.index}"
  description = "slave-a-${count.index}"
  zone = "${element(var.zones, count.index)}"

  resources {
    cores  = "1"
    memory = "1"
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.base_image.id}"
      type_id = "network-nvme"
      size = "31"
    }
  }

  metadata {
    ssh-keys  = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    subnet_id = "${element(local.user_subnet_a_ids, count.index)}"
  }

}


resource "yandex_compute_instance" "slave_b" {
  count       = "2"
  name        = "slave-b-${count.index}"
  hostname    = "slave-b-${count.index}"
  description = "slave-b-${count.index}"
  zone = "${element(var.zones, count.index)}"

  resources {
    cores  = "1"
    memory = "1"
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.base_image.id}"
      type_id = "network-nvme"
      size = "31"
    }
  }

  metadata {
    ssh-keys  = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    subnet_id = "${element(local.user_subnet_b_ids, count.index)}"
  }

}


resource "yandex_compute_instance" "bastion_a" {
  name        = "bastion-a"
  hostname    = "bastion-a"
  description = "bastion-a"
  zone = "${element(var.zones, 0)}"

  resources {
    cores  = "1"
    memory = "1"
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.base_image.id}"
      type_id = "network-nvme"
      size = "31"
    }
  }

  metadata {
    ssh-keys  = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    subnet_id = "${element(local.user_subnet_a_ids, 0)}"
    nat       = true
  }

}



resource "yandex_compute_instance" "bastion_b" {
  name        = "bastion-b"
  hostname    = "bastion-b"
  description = "bastion-b"
  zone = "${element(var.zones, 0)}"

  resources {
    cores  = "1"
    memory = "1"
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.base_image.id}"
      type_id = "network-nvme"
      size = "31"
    }
  }

  metadata {
    ssh-keys  = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    subnet_id = "${element(local.user_subnet_b_ids, 0)}"
    nat       = true
  }

}
