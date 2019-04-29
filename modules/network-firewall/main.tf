data "google_compute_subnetwork" "public_subnetwork" {
  self_link = "${var.public_subnetwork}"
}

data "google_compute_subnetwork" "private_subnetwork" {
  self_link = "${var.public_subnetwork}"
}

// Define tags as locals so they can be interpolated off of + exported
locals {
  public              = "public"
  private             = "private"
  private_persistence = "private-persistence"
}

# ---------------------------------------------------------------------------------------------------------------------
# public - allow ingress from anywhere
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "public_allow_all_inbound" {
  name    = "${var.name}-public-allow-ingress"
  network = "${var.network}"

  target_tags   = ["${local.public}"]
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# private - allow ingress from within this network
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "private_allow_all_network_inbound" {
  name    = "${var.name}-private-allow-network-inbound"
  network = "${var.network}"

  target_tags = ["${local.private}"]
  direction   = "INGRESS"

  source_ranges = [
    "${data.google_compute_subnetwork.public_subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.public_subnetwork.secondary_ip_range.0.ip_cidr_range}",
    "${data.google_compute_subnetwork.private_subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.private_subnetwork.secondary_ip_range.0.ip_cidr_range}",
  ]

  priority = "1000"

  allow {
    protocol = "all"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# private-persistence - allow ingress from `private` and `private-persistence` instances in this network
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "private_allow_restricted_network_inbound" {
  name    = "${var.name}-allow-restricted-inbound"
  network = "${var.network}"

  target_tags = ["${local.private_persistence}"]
  direction   = "INGRESS"

  # source_tags is implicitly within this network; tags are only applied to instances that rest within the same network
  source_tags = ["${local.private}", "${local.private_persistence}"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}
