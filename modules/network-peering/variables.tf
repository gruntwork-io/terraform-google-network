# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "first_network" {
  description = "The self_link reference to the first network to peer"
}

variable "second_network" {
  description = "The self_link reference to the second network to peer"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "A naming format for the network peerings"
  value       = "peering"
}
