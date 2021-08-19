terraform {
  # This module is now only being tested with Terraform 1.0.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 1.0.x code.
  required_version = ">= 0.12.26"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create a Management Network for shared services
# ---------------------------------------------------------------------------------------------------------------------

module "management_network" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.1.2"
  source = "../../modules/vpc-network"

  name_prefix = var.name_prefix
  project     = var.project
  region      = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# Create the bastion host to access private instances
# ---------------------------------------------------------------------------------------------------------------------

module "bastion_host" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-network.git//modules/bastion-host?ref=v0.1.2"
  source = "../../modules/bastion-host"

  instance_name = "${var.name_prefix}-vm"
  subnetwork    = module.management_network.public_subnetwork

  project = var.project
  zone    = var.zone
}

# ---------------------------------------------------------------------------------------------------------------------
# Create a private instance to use alongside the bastion host.
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_instance" "private" {
  name         = "${var.name_prefix}-private"
  machine_type = "n1-standard-1"
  zone         = var.zone

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

  metadata = {
    enable-oslogin = "TRUE"
  }
}
