# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "network" {
  description = "A reference (self_link) to the VPC network to apply firewall rules to"
  type        = string
}

variable "public_subnetwork" {
  description = "A reference (self_link) to the public subnetwork of the network"
  type        = string
}

variable "private_subnetwork" {
  description = "A reference (self_link) to the private subnetwork of the network"
  type        = string
}

variable "project" {
  description = "The project to create the firewall rules in. Must match the network project."
  type        = string
}

variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}

