# ---------------------------------------------------------------------------------------------------------------------
# Create a Management Network for shared services
# ---------------------------------------------------------------------------------------------------------------------

module "management_network" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.0.1"
  source = "../../modules/vpc-network"

  name    = "${var.name}"
  project = "${var.project}"
  region  = "${var.region}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create instances to tag & test connectivity with
# ---------------------------------------------------------------------------------------------------------------------

data "google_compute_zones" "available" {
  project = "${var.project}"
  region  = "${var.region}"
}

// This instance acts as an arbitrary internet address for testing purposes
resource "google_compute_instance" "default_network" {
  name         = "${var.instance_name_prefix}-default-network"
  machine_type = "n1-standard-1"
  zone         = "${data.google_compute_zones.available.names[0]}"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "public_with_ip" {
  name         = "${var.instance_name_prefix}-public-with-ip"
  machine_type = "n1-standard-1"
  zone         = "${data.google_compute_zones.available.names[0]}"

  allow_stopping_for_update = true

  tags = ["${module.management_network.public}"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${module.management_network.public_subnetwork}"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "public_without_ip" {
  name         = "${var.instance_name_prefix}-public-without-ip"
  machine_type = "n1-standard-1"
  zone         = "${data.google_compute_zones.available.names[0]}"

  allow_stopping_for_update = true

  tags = ["${module.management_network.public}"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${module.management_network.public_subnetwork}"
  }
}
