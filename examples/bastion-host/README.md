# Bastion Module

This example shows how to use the Bastion Host module to configure access to resources internal to a network through a
bastion host with OS Login.

This example uses the `default` network and subnetwork to configure the bastion host, but they should be discouraged in
production environments; instead, use an explicitly defined network such as a [Management Network](../network-management)
or an [Application Network](../network-host-application).

## Limitations

When OS Login is in use, SSH keys can't be added to instances manually.

## How do you run these examples?

1. Install [Terraform](https://www.terraform.io/).
1. Make sure you have Python installed (version 2.x) and in your `PATH`.
1. Open `variables.tf`,  and fill in any required variables that don't have a
default.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
