# VPC Network Module

The VPC Network module creates a [Virtual Private Cloud (VPC) network](https://cloud.google.com/vpc/docs/using-vpc) on
Google Cloud Platform (GCP) following best practices.

When configuring networks for your organisation, you should generally define these "types" of networks:

- `management` - a single network that runs your internal services such as DevOps services like Jenkins, peering to your
  application networks. This network should run in the same project as its services.

- `application`- a network per environment (`staging`, `production`, etc.), running multiple services owned by multiple
  teams. Most application networks should be [host projects](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/project-host-configuration),
  allowing you to share a single network across multiple "service" projects that each contain a single application or
  service. See [host project](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/project-host-configuration)
  for more details.

For more details on specific configuration of each type, see the [examples](https://github.com/gruntwork-io/terraform-google-network/tree/master/examples)
provided in this module.

## How do you use this module?

- See the [root README](https://github.com/gruntwork-io/terraform-google-network/blob/master/README.md) for instructions
  on using Terraform modules.
- See the [examples](https://github.com/gruntwork-io/terraform-google-network/tree/master/examples) folder for example
  usage.
- See [variables.tf](https://github.com/gruntwork-io/terraform-google-network/blob/master/modules/vpc-network/variables.tf)
  for all the variables you can set on this module.
- See [outputs.tf](https://github.com/gruntwork-io/terraform-google-network/blob/master/modules/vpc-network/outputs.tf)
  for all the variables that are outputted by this module.

## What is a VPC network?

See [the repo's root README](https://github.com/gruntwork-io/terraform-google-network/blob/master/README.md) to learn more about VPC networks.

## Access Tier

In this module, there are several "access tiers"- the pair of an instance's subnetwork and [network `tags`](https://cloud.google.com/vpc/docs/add-remove-network-tags).
By placing instances in the appropriate subnetworks and using restrictive network tags, you can guarantee that only the
intended traffic is able to reach your infrastructure.

Instances in the network must be tagged with the following network tags in order for inbound traffic to be allowed to
reach them. All other inbound traffic is denied, including internal traffic;

- `public` - allow inbound traffic from all sources

- `public-restricted` - allow inbound traffic from specific subnetworks on the internet

- `private` - allow inbound traffic from within this network

- `private-persistence` - allow inbound traffic from tagged sources within this network, excluding instances tagged
  `public`

See the [network-firewall](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/network-firewall)
submodule for more details.

A VPC network defines two subnetworks instances can reside in;

- `public` - instances are able to communicate over the public internet through Cloud NAT if an external IP was not
  provided

- `private` - instances are exclusively able to communicate within your network or with private Google services if an
  external IP was not provided

## What is Private Google Access?

[Private Google Access](https://cloud.google.com/vpc/docs/configure-private-google-access) is a GCP feature where
instances within your network that don't have public IP addresses assigned can access most Google APIs and services
without NAT or a bastion. Private Google Access is enabled at the subnetwork level, and subnetworks created using this
module will have Private Google Access enabled.

## What is alias IP?

An [alias IP range](https://cloud.google.com/vpc/docs/alias-ip) allows you to use a different IP address for each of
your services such as container pods on a VM.

When using alias IP, anti-spoofing checks are performed against traffic, ensuring that traffic exiting VMs uses VM IP
addresses and pod IP addresses as source addresses, and that that VMs do not send traffic with arbitrary source IP
addresses.

When you configure separate address ranges for VMs and their services, you can set up firewall rules for alias ranges
separately from the primary range. For example, you can allow certain traffic for container pods and deny similar
traffic for the VM's primary IP address.

### How is a secondary range connected to an alias IP range?

While all subnetworks have a primary address range, the range VM's internal addresses are drawn from, and alias IPs
could be drawn from the primary range, subnetworks can also define a secondary range for exclusive use with alias IP
ranges. This simplifies constructing firewall rules, and helps an organisation ensure that services are running securely
in containers distinct from the VM.

This module automatically configures secondary ranges for use with alias IP.

## What are VPC Flow Logs?

[VPC Flow Logs](https://cloud.google.com/vpc/docs/using-flow-logs) are a feature where subnetworks in your network will
have their traffic flow between VM instances sampled and sent to Stackdriver; there, you can use them for a variety of
purposes including forensics and expense optimization. Only TCP and UDP traffic is logged. Flow logging is enabled by
default in this module, and can be disabled by setting the `log_config` variable to `null`.

## Network Architecture

This network architecture is inspired by the VPC Architecture described by Ben Whaley in his blog post
[A Reference VPC Architecture](https://www.whaletech.co/2014/10/02/reference-vpc-architecture.html). Notably, while the
reference architecture made the distinction between machines by subnetwork tier, this module uses [network `tags`](https://cloud.google.com/vpc/docs/add-remove-network-tags)
to do so.

Additionally, the hard distinction between "Application" and "Management" in terms of tiers has been removed- either
can include or exclude "persistence" instances. Instead, Whaley's "Application" networks are generally host networks
with attached service projects, and "Management" networks should be used with services inside the same project.

## Gotchas

In order to allow any inter-network communication, instances _must_ be tagged with one of `public`, `private`, or
`private-persistence`. See the [network-firewall](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/network-firewall)
submodule for more details.
