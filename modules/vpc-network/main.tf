# ---------------------------------------------------------------------------------------------------------------------
# Create the Network & corresponding Router to attach other resources to
# Networks that preserve the default route are automatically enabled for Private Google Access to GCP services
# provided subnetworks each opt-in; in general, Private Google Access should be the default.
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_network" "vpc" {
  name                    = "${var.name}-network"
  project                 = "${var.project}"

  # Always define custom subnetworks- one subnetwork for region isn't useful for an opinionated setup
  auto_create_subnetworks = "false"

  # A global routing mode can have an unexpected impact on load balancers; always use a regional mode
  routing_mode = "REGIONAL"
}

resource "google_compute_router" "vpc_router" {
  name    = "${var.name}-router"
  network = "${google_compute_network.vpc.self_link}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Public Subnetwork Config
# Public internet access is automatically configured by the default gateway for 0.0.0.0/0
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_subnetwork" "vpc_subnetwork_public" {
  name          = "${var.name}-subnetwork-public"
  region        = "${var.region}"
  network       = "${google_compute_network.vpc.self_link}"

  private_ip_google_access = true
  ip_cidr_range = "10.0.0.0/24"

  secondary_ip_range {
    range_name = "app-services"
    ip_cidr_range = "10.0.1.0/24"
  }

  #TODO - what does this field do?
  enable_flow_logs = false
}

# ---------------------------------------------------------------------------------------------------------------------
# Private Subnetwork Config
# External access is configured with Cloud NAT, which subsumes egress traffix
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_router_nat" "vpc_nat" {
  name   = "${var.name}-nat"
  router = "${google_compute_router.vpc_router.name}"
  region = "${var.region}"

  #TODO: Manually define NAT IP Pool
  nat_ip_allocate_option = "AUTO_ONLY"

  # "Manually" define the subnetworks for which the NAT is used, so that we can exclude the public subnetwork
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "${google_compute_subnetwork.vpc_subnetwork_private.self_link}"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_subnetwork" "vpc_subnetwork_private" {
  name          = "${var.name}-subnetwork-private"
  region        = "${var.region}"
  network       = "${google_compute_network.vpc.self_link}"

  private_ip_google_access = true
  ip_cidr_range = "10.0.2.0/24"

  #TODO - what does this field do?
  enable_flow_logs = false
}
