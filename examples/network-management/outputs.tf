output "network" {
  description = "A reference (self_link) to the VPC network"
  value       = module.management_network.network
}

# ---------------------------------------------------------------------------------------------------------------------
# Public Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork"
  value       = module.management_network.public_subnetwork
}

output "public_subnetwork_cidr_block" {
  value = module.management_network.public_subnetwork_cidr_block
}

output "public_subnetwork_gateway" {
  value = module.management_network.public_subnetwork_gateway
}

output "public_subnetwork_secondary_cidr_block" {
  value = module.management_network.public_subnetwork_secondary_cidr_block
}

# ---------------------------------------------------------------------------------------------------------------------
# Private Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "private_subnetwork" {
  description = "A reference (self_link) to the private subnetwork"
  value       = module.management_network.private_subnetwork
}

output "private_subnetwork_cidr_block" {
  value = module.management_network.private_subnetwork_cidr_block
}

output "private_subnetwork_gateway" {
  value = module.management_network.private_subnetwork_gateway
}

output "private_subnetwork_secondary_cidr_block" {
  value = module.management_network.private_subnetwork_secondary_cidr_block
}

# ---------------------------------------------------------------------------------------------------------------------
# Access Tier - Network Tags
# ---------------------------------------------------------------------------------------------------------------------

output "public" {
  description = "The network tag string used for the public access tier"
  value       = module.management_network.public
}

output "private" {
  description = "The network tag string used for the private access tier"
  value       = module.management_network.private
}

output "private_persistence" {
  description = "The network tag string used for the private-persistence access tier"
  value       = module.management_network.private_persistence
}

# ---------------------------------------------------------------------------------------------------------------------
# Instance Info (primarily for testing)
# ---------------------------------------------------------------------------------------------------------------------

output "instance_default_network" {
  description = "A reference (self link) to an instance in the default network. Note that the default network allows SSH."
  value       = google_compute_instance.default_network.self_link
}

output "instance_public_with_ip" {
  description = "A reference (self link) to the instance tagged as public in a public subnetwork with an external IP"
  value       = google_compute_instance.public_with_ip.self_link
}

output "instance_public_without_ip" {
  description = "A reference (self link) to the instance tagged as public in a public subnetwork without an internet IP"
  value       = google_compute_instance.public_without_ip.self_link
}

output "instance_private_public" {
  description = "A reference (self link) to the instance tagged as private in a public subnetwork"
  value       = google_compute_instance.private_public.self_link
}

output "instance_private" {
  description = "A reference (self link) to the instance tagged as private in a private subnetwork"
  value       = google_compute_instance.private.self_link
}

output "instance_private_persistence" {
  description = "A reference (self link) to the instance tagged as private-persistence in a private subnetwork"
  value       = google_compute_instance.private_persistence.self_link
}

