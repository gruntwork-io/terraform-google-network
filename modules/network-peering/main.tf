resource "google_compute_network_peering" "first" {
  name         = "${var.name_prefix}-first"
  network      = "${var.first_network}"
  peer_network = "${var.second_network}"
}

resource "google_compute_network_peering" "second" {
  name         = "${var.name_prefix}-second"
  network      = "${var.second_network}"
  peer_network = "${var.first_network}"
}
