# Host Network for Applications

This example creates a "host" network that can be shared across multiple projects, meant for multiple teams within an
organization to run their services within with limited network configuration privileges. This network is appropriate to
run a single environment- `production`, `staging`, etc.

This example showcases a service project being created and used to run a service team's application. While it's present
in a single Terraform configuration (`.tf`) file, two distinct provider aliases are used to showcase the different
credentials the network operators and service teams use.

## Limitations

Every network within the host project will be a host network, and the host project cannot be a service project (eg:
share a network with another host project).

While networks on Google Cloud Platform (GCP) are global, most resources that reside inside a VPC network live inside a
regional subnetwork. This example showcases an application running within a single region.

## How do you run these examples?

1. Install [Terraform](https://www.terraform.io/).
1. Make sure you have Python installed (version 2.x) and in your `PATH`.
1. Open `variables.tf`,  and fill in any required variables that don't have a
default.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
