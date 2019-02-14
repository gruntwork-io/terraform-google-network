// Use subnetwork datasources so we can interpolate ranges off of them.
// TODO: Use self_link directly when https://github.com/GoogleCloudPlatform/magic-modules/pull/1377
// is merged
data "google_compute_subnetwork" "public_subnetwork" {
  name    = "${basename(var.public_subnetwork)}"
  region  = "${var.region}"
  project = "${var.project}"
}

data "google_compute_subnetwork" "private_subnetwork" {
  name    = "${basename(var.public_subnetwork)}"
  region  = "${var.region}"
  project = "${var.project}"
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
  name    = "public-allow-all-inbound"
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
  name    = "private-allow-all-network-inbound"
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
  name    = "private-allow-restricted-network-inbound"
  network = "${var.network}"

  target_tags = ["${local.private_persistence}"]
  direction   = "INGRESS"

  source_ranges = [
    "${data.google_compute_subnetwork.public_subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.public_subnetwork.secondary_ip_range.0.ip_cidr_range}",
    "${data.google_compute_subnetwork.private_subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.private_subnetwork.secondary_ip_range.0.ip_cidr_range}",
  ]

  source_tags = ["${local.private}", "${local.private_persistence}"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}
