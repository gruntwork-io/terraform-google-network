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

variable "public_subnetwork_secondary_range_name" {
  description = "The name associated with the pod subnetwork secondary range, used when adding an alias IP range to a VM instance. The name must be 1-63 characters long, and comply with RFC1035. The name must be unique within the subnetwork."
  type        = string
  default     = "public-cluster"
}

variable "public_services_secondary_range_name" {
  description = "The name associated with the services subnetwork secondary range, used when adding an alias IP range to a VM instance. The name must be 1-63 characters long, and comply with RFC1035. The name must be unique within the subnetwork."
  type        = string
  default     = "public-services"
}

variable "secondary_cidr_block" {
  description = "The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_services_secondary_cidr_block" {
  description = "The IP address range of the VPC's public services secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27. Note: this variable is optional and is used primarily for backwards compatibility, if not specified a range will be calculated using var.secondary_cidr_block, var.secondary_cidr_subnetwork_width_delta and var.secondary_cidr_subnetwork_spacing."
  type        = string
  default     = null
}

variable "private_services_secondary_cidr_block" {
  description = "The IP address range of the VPC's private services secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27. Note: this variable is optional and is used primarily for backwards compatibility, if not specified a range will be calculated using var.secondary_cidr_block, var.secondary_cidr_subnetwork_width_delta and var.secondary_cidr_subnetwork_spacing."
  type        = string
  default     = null
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

variable "log_config" {
  description = "The logging options for the subnetwork flow logs. Setting this value to `null` will disable them. See https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html for more information and examples."
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })

  default = {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

variable "allowed_public_restricted_subnetworks" {
  description = "The public networks that is allowed access to the public_restricted subnetwork of the network"
  default     = []
  type        = list(string)
}
