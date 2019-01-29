# Network Peering Module

The Network Peering module creates [VPC network peering connections](https://cloud.google.com/vpc/docs/vpc-peering)
between networks. Normal networks are isolated, but some traffic may need to
flow between them, such as allowing DevOps tools running in a
[management network](../network-management) to talk to apps or services in an
[application network](../vpc-network).

When using a [host project](../project-host-configuration) with component host
networks, peerings should be made in the host project.

## How do you use this module?

* See the [root README](/README.md) for instructions on using Terraform modules.
* See the [examples](/examples) folder for example usage.
* See [variables.tf](./variables.tf) for all the variables you can set on this module.
* See [outputs.tf](./outputs.tf) for all the variables that are outputed by this module.
