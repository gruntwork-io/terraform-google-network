# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The project ID for the network"
  type        = string
}

variable "region" {
  description = "The region for subnetworks in the network"
  type        = string
}

variable "name_prefix" {
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  default     = "10.0.0.0/16"
  type        = string
}

variable "cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork netmask; an /16 network and a /20 subnetwork would be 4."
  type        = number
  default     = 4
}

variable "cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type."
  type        = number
  default     = 0
}

variable "secondary_cidr_block" {
  description = "The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  type        = string
  default     = "10.1.0.0/16"
}

variable "secondary_cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork's secondary range netmask; an /16 network and a /20 subnetwork would be 4."
  type        = number
  default     = 4
}

variable "secondary_cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type's secondary ranges."
  type        = number
  default     = 0
}

variable "enable_flow_logging" {
  description = "Whether to enable VPC Flow Logs being sent to Stackdriver (https://cloud.google.com/vpc/docs/using-flow-logs)"
  type        = bool
  default     = true
}

variable allowed_public_restricted_subnetworks {
  description = "The public networks that is allowed access to the public_restricted subnetwork of the network"
  default     = []
  type        = list(string)
}
