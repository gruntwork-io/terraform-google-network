output "network" {
  description = "A reference (self_link) to the VPC network"
  value       = "${module.application_network.network}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Public Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork"
  value       = "${module.application_network.public_subnetwork}"
}

output "public_subnetwork_cidr_block" {
  value = "${module.application_network.public_subnetwork_cidr_block}"
}

output "public_subnetwork_gateway" {
  value = "${module.application_network.public_subnetwork_gateway}"
}

output "public_subnetwork_secondary_cidr_block" {
  value = "${module.application_network.public_subnetwork_secondary_cidr_block}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Private Subnetwork Outputs
# ---------------------------------------------------------------------------------------------------------------------

output "private_subnetwork" {
  description = "A reference (self_link) to the private subnetwork"
  value       = "${module.application_network.private_subnetwork}"
}

output "private_subnetwork_cidr_block" {
  value = "${module.application_network.private_subnetwork_cidr_block}"
}

output "private_subnetwork_gateway" {
  value = "${module.application_network.private_subnetwork_gateway}"
}

output "private_subnetwork_secondary_cidr_block" {
  value = "${module.application_network.private_subnetwork_secondary_cidr_block}"
}
