# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The name of the GCP Project where all resources will be launched."
}

variable "region" {
  description = "The Region in which all GCP resources will be launched."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name of the VPC network."
  default     = "example-management-network"
}

variable "instance_name_prefix" {
  description = "A name prefix to apply to VM instances created as part of this example"
  default     = "management"
}
