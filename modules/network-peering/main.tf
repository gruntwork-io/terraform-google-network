terraform {
  # This module is now only being tested with Terraform 0.14.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.14.x code.
  required_version = ">= 0.12.26"
}

resource "google_compute_network_peering" "first" {
  name                 = "${var.name_prefix}-first"
  network              = var.first_network
  peer_network         = var.second_network
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}

resource "google_compute_network_peering" "second" {
  name                 = "${var.name_prefix}-second"
  network              = var.second_network
  peer_network         = var.first_network
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}
