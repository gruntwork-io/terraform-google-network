# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "instance_name" {
  description = "The name of the VM instance"
  type        = string
}

variable "subnetwork" {
  description = "A reference (self_link) to the subnetwork to place the bastion host in"
  type        = string
}

variable "project" {
  description = "The project to create the bastion host in. Must match the subnetwork project."
  type        = string
}

variable "zone" {
  description = "The zone to create the bastion host in. Must be within the subnetwork region."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "tag" {
  description = "The GCP network tag to apply to the bastion host for firewall rules. Defaults to 'public', the expected public tag of this module."
  type        = string
  default     = "public"
}

variable "machine_type" {
  description = "The machine type of the instance."
  type        = string
  default     = "f1-micro"
}

variable "source_image" {
  description = "The source image to build the VM using. Specified by path reference or by {{project}}/{{image-family}}"
  type        = string
  default     = "gce-uefi-images/ubuntu-1804-lts"
}

variable "startup_script" {
  description = "The script to be executed when the bastion host starts. It can be used to install additional software and/or configure the host."
  type        = string
  default     = ""
}

variable "static_ip" {
  description = "A static IP address to attach to the instance. The default will allocate an ephemeral IP"
  type        = string
  default     = null
}
