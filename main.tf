terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create a Management Network for shared services
# ---------------------------------------------------------------------------------------------------------------------

module "management_network" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.1.2"
  source = "./modules/vpc-network"

  name_prefix = var.name_prefix
  project     = var.project
  region      = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# Create instances to tag & test connectivity with
# ---------------------------------------------------------------------------------------------------------------------

data "google_compute_zones" "available" {
  project = var.project
  region  = var.region
}

// This instance acts as an arbitrary internet address for testing purposes
resource "google_compute_instance" "default_network" {
  name         = "${var.name_prefix}-default-network"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]
  project      = var.project

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
  name         = "${var.name_prefix}-public-with-ip"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]
  project      = var.project

  allow_stopping_for_update = true

  tags = [module.management_network.public]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = module.management_network.public_subnetwork

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "public_without_ip" {
  name         = "${var.name_prefix}-public-without-ip"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]
  project      = var.project

  allow_stopping_for_update = true

  tags = [module.management_network.public]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = module.management_network.public_subnetwork
  }
}

resource "google_compute_instance" "private_public" {
  name         = "${var.name_prefix}-private-public"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]
  project      = var.project

  allow_stopping_for_update = true

  tags = [module.management_network.private]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = module.management_network.public_subnetwork
  }
}

resource "google_compute_instance" "private" {
  name         = "${var.name_prefix}-private"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]
  project      = var.project

  allow_stopping_for_update = true

  tags = [module.management_network.private]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = module.management_network.private_subnetwork
  }
}

resource "google_compute_instance" "private_persistence" {
  name         = "${var.name_prefix}-private-persistence"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]
  project      = var.project

  allow_stopping_for_update = true

  tags = [module.management_network.private_persistence]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = module.management_network.private_subnetwork
  }
}

