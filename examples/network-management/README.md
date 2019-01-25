# Management Network

This example creates a management network meant to be used by operators in a
single project. It can be connected to application networks with network
peering to access environments like `production` or `staging`.

## Limitations

While networks on Google Cloud Platform (GCP) are global, most resources that
reside inside a VPC network live inside a regional subnetwork. This example
uses a single region to run the example management services.

## How do you run these examples?

1. Install [Terraform](https://www.terraform.io/).
1. Make sure you have Python installed (version 2.x) and in your `PATH`.
1. Open `variables.tf`,  and fill in any required variables that don't have a
default.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
