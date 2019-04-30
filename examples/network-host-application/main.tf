module "application_network" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.0.1"
  source = "../../modules/vpc-network"

  name_prefix = "${var.name_prefix}"
  project     = "${var.project}"
  region      = "${var.region}"
}

module "project_host_configuration" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:gruntwork-io/terraform-google-network.git//modules/project-host-configuration?ref=v0.0.1"
  source = "../../modules/project-host-configuration"

  project = "${var.project}"
}
