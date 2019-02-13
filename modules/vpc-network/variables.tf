# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The project ID for the network"
}

variable "region" {
  description = "The region for subnetworks in the network"
}

variable "name" {
  description = "The prefix for names of network resources"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  default     = "10.0.0.0/16"
}

variable "cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork netmask; an /16 network and a /20 subnetwork would be 4."
  default     = "4"
}

variable "cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type."
  default     = "0"
}

variable "secondary_cidr_block" {
  description = "The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  default     = "10.1.0.0/16"
}

variable "secondary_cidr_subnetwork_width_delta" {
  description = "The difference between your network and subnetwork's secondary range netmask; an /16 network and a /20 subnetwork would be 4."
  default     = "4"
}

variable "secondary_cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type's secondary ranges."
  default     = "0"
}

variable "enable_flow_logging" {
  description = "Whether to enable VPC Flow Logs being sent to Stackdriver (https://cloud.google.com/vpc/docs/using-flow-logs)"
  default     = "true"
}
