output "network" {
  description = "A reference (self_link) to the VPC network"
  value       = "${google_compute_network.vpc.self_link}"
}

output "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork"
  value       = "${google_compute_subnetwork.vpc_subnetwork_public.self_link}"
}

output "private_subnetwork" {
  description = "A reference (self_link) to the private subnetwork"
  value       = "${google_compute_subnetwork.vpc_subnetwork_private.self_link}"
}
