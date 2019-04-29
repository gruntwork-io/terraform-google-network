# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "network" {
  description = "A reference (self_link) to the VPC network to apply firewall rules to"
}

variable "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork of the network"
}

variable "private_subnetwork" {
  description = "A reference (self_link) to the private subnetwork of the network"
}

variable "name" {
  description = "A name prefix to apply to resources"
}
