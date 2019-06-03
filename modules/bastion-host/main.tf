# ---------------------------------------------------------------------------------------------------------------------
# Create an instance with OS Login configured to use as a bastion host.
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_instance" "bastion_host" {
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  tags = ["${var.tag}"]

  boot_disk {
    initialize_params {
      image = "${var.source_image}"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    // Provide an empty access_config block to receive an ephemeral IP
    access_config {}
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}
