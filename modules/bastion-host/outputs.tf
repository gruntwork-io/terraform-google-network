output "instance" {
  description = "A reference (self_link) to the bastion host's VM instance"
  value       = "${google_compute_network.vpc.self_link}"
}

output "address" {
  description = "The public IP of the bastion host."
  value       = "${google_compute_network.vpc.self_link}"
}
