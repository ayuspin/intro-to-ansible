provider "google" {
  project = "intro-to-ansible"
  region  = "europe-west4"
  zone    = "europe-west4-a"
}

resource "google_compute_instance" "vm_instance" {
  count        = 3
  name         = "vm-instance-${count.index}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network       = "default"
    access_config {
    }
  }
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = "https://www.googleapis.com/compute/v1/projects/intro-to-ansible/global/networks/default"

  allow {
  protocol = "tcp"
  ports = ["80", "443"]
  }
}
