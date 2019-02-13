// Use subnetwork datasources so we can interpolate ranges off of them.
// TODO: Use self_link directly when https://github.com/GoogleCloudPlatform/magic-modules/pull/1377
// is merged
data "google_compute_subnetwork" "public-subnetwork" {
  name    = "${basename(var.public_subnetwork)}"
  region  = "${var.region}"
  project = "${var.project}"
}

data "google_compute_subnetwork" "private-subnetwork" {
  name    = "${basename(var.public_subnetwork)}"
  region  = "${var.region}"
  project = "${var.project}"
}

# ---------------------------------------------------------------------------------------------------------------------
# public - allow ingress from anywhere
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_firewall" "public_allow_all_inbound" {
  name    = "public-allow-all-allow"
  network = "${var.network}"

  target_tags   = ["public"]
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

  target_tags = ["private"]
  direction   = "INGRESS"

  source_ranges = [
    "${data.google_compute_subnetwork.public-subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.public-subnetwork.secondary_ip_range.0.ip_cidr_range}",
    "${data.google_compute_subnetwork.private-subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.private-subnetwork.secondary_ip_range.0.ip_cidr_range}",
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

  target_tags = ["private-persistence"]
  direction   = "INGRESS"

  source_ranges = [
    "${data.google_compute_subnetwork.public-subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.public-subnetwork.secondary_ip_range.0.ip_cidr_range}",
    "${data.google_compute_subnetwork.private-subnetwork.ip_cidr_range}",
    "${data.google_compute_subnetwork.private-subnetwork.secondary_ip_range.0.ip_cidr_range}",
  ]

  source_tags = ["private", "private-persistence"]

  priority = "1000"

  allow {
    protocol = "all"
  }
}
