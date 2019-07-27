terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create an instance with OS Login configured to use as a bastion host.
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_instance" "bastion_host" {
  project      = var.project
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = [var.tag]

  boot_disk {
    initialize_params {
      image = var.source_image
    }
  }

  network_interface {
    subnetwork = var.subnetwork

    // If var.static_ip is set use that IP, otherwise this will generate an ephemeral IP
    access_config {
      nat_ip = var.static_ip
    }
  }

  metadata_startup_script = var.startup_script

  metadata = {
    enable-oslogin = "TRUE"
  }
}
