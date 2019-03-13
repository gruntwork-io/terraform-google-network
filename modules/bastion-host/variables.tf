# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "instance" {
  description = "The name of the VM instance"
}

variable "subnetwork" {
  description = "A reference (self_link) to the subnetwork to place the bastion host in"
}

variable "project" {
  description = "The project to create the bastion host in. Must match the subnetwork project."
}

variable "zone" {
  description = "The zone to create the bastion host in. Must be within the subnetwork region."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "tag" {
  description = "The GCP network tag to apply to the bastion host for firewall rules. Defaults to 'public', the expected public tag of this module."
  default     = "public"
}

variable "machine_type" {
  description = "The machine type of the instance."
  default     = "n1-standard-1"
}
