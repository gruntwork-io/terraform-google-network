output "address" {
  description = "The public IP of the bastion host."
  value       = module.bastion_host.address
}

output "private_instance" {
  description = "A reference (self_link) to the private instance"
  value       = google_compute_instance.private.self_link
}

