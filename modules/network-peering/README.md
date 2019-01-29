# Network Peering Module

The Network Peering module creates [VPC network peering connections](https://cloud.google.com/vpc/docs/vpc-peering)
between networks. Normall networks are isolated, but some traffic may need to
flow between them, such as allowing DevOps tools running in a
[management network](../network-management) to talk to apps or services in an
[application network](../network-application).

When using a [host project](../project-host-configuration) with component host
networks, peerings should be made in the host project.

## How do you use this module?

* See the [root README](/README.md) for instructions on using Terraform modules.
* See the [examples](/examples) folder for example usage.
* See [variables.tf](./variables.tf) for all the variables you can set on this module.
* See [outputs.tf](./outputs.tf) for all the variables that are outputed by this module.

## What is a VPC network?
A [Virtual Private Cloud (VPC) network](https://cloud.google.com/vpc/)  or
"network" is a logically isolated section of your Google Cloud Platform (GCP)
infrastructure. A network on GCP is a virtual network that allows you to control
connectivity between your resources and services both within GCP and external to
it.

Networks are global on GCP, and they're split into subnetworks, ranges of
private IP addresses defined at the regional level. You can control traffic in
and out of your networks- as well as individual instances- with firewall rules.
<!-- TODO(rileykarson): Expand on GCP network features -->
