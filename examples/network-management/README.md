# Management Network

This example creates a management network meant to be used by operators in a single project. It can be connected to
application networks with network peering to access environments like `production` or `staging`.

## What are the instances included in this example?

See the diagram below for a visual guide to the instances defined in this example. You can see an example of which
connections between them are valid by browsing the test cases under [this example's tests](../../test/network_test.go)

![Network Diagram](https://raw.githubusercontent.com/gruntwork-io/terraform-google-network/master/.img/management-network-diagram.png)

## Limitations

While networks on Google Cloud Platform (GCP) are global, most resources that reside inside a VPC network live inside a
regional subnetwork. This example uses a single region to run the example management services.

## How do you run these examples?

1. Install [Terraform](https://www.terraform.io/).
1. Make sure you have Python installed (version 2.x) and in your `PATH`.
1. Open `variables.tf`,  and fill in any required variables that don't have a
default.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
