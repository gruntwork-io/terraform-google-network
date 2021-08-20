# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "first_network" {
  description = "The self_link reference to the first network to peer"
  type        = string
}

variable "second_network" {
  description = "The self_link reference to the second network to peer"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
  default     = "peering"
}

variable "export_custom_routes" {
  description = "Export custom routes to the peered network"
  type        = bool
  default     = false
}

variable "import_custom_routes" {
  description = "Import custom routes from the peered network"
  type        = bool
  default     = false
}

