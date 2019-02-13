# VPC Network Module

The VPC Network module creates a [Virtual Private Cloud (VPC) network](https://cloud.google.com/vpc/docs/using-vpc)
on Google Cloud Platform (GCP) following best practices.

When configuring networks for your organisation, you should generally define
these "types" of networks:

* `management` - a single network that runs your internal services such as
DevOps services like Jenkins, peering to your application networks. This network
should run in the same project as its services.

* `application`- a network per environment (`staging`, `production`, etc.),
running multiple services owned by multiple teams. Most application networks
should be [host projects](../project-host-configuration), allowing you to share
a single network across multiple "service" projects that each contain a single
application or service. See [host project](../project-host-configuration) for
more details.

For more details on specific configuration of each type, see the [examples](../examples)
provided in this module.

## How do you use this module?

* See the [root README](/README.md) for instructions on using Terraform modules.
* See the [examples](/examples) folder for example usage.
* See [variables.tf](./variables.tf) for all the variables you can set on this module.
* See [outputs.tf](./outputs.tf) for all the variables that are outputed by this module.

## What is a VPC network?

See [the repo's root README](../../README.md) to learn more about VPC networks.

## Subnetwork Tiers

<!-- TODO(rileykarson): Expand more thoroughly on tier capabilities -->
A VPC network defines these "tiers" of subnetworks;

* `public` - accessible from the public internet

* `private` - only accessible from within your network or private Google
services

<!-- TODO(rileykarson): Are private persistence subnetworks necessary? -->
* `private persistence` - (Optional) only accessible from your network (excluding `public`)
or private Google services

## What is Private Google Access?

[Private Google Access](https://cloud.google.com/vpc/docs/configure-private-google-access)
is a GCP feature where instances within your network that don't have public IP
addresses assigned can  access most Google APIs and services without NAT or a
bastion. Private Google Access is enabled at the subnetwork level, and
subnetworks created using this module will have Private Google Access enabled.

## What is alias IP?

An [alias IP range](https://cloud.google.com/vpc/docs/alias-ip) allows you to
use a different IP address for each of your services such as container pods on a
VM.

When using alias IP, anti-spoofing checks are performed against traffic,
ensuring that traffic exiting VMs uses VM IP addresses and pod IP addresses as
source addresses, and that that VMs do not send traffic with arbitrary source IP
addresses.

When you configure separate address ranges for VMs and their services, you can
set up firewall rules for alias ranges separately from the primary range. For
example, you can allow certain traffic for container pods and deny similar
traffic for the VM's primary IP address.

### How is a secondary range connected to an alias IP range?

While all subnetworks have a primary address range, the range VM's internal
addresses are drawn from, and alias IPs could be drawn from the primary range,
subnetworks can also define a secondary range for exclusive use with alias
IP ranges. This simplifies constructing firewall rules, and helps an
organisation ensure that services are running securely in containers distinct
from the VM.

This module automatically configures secondary ranges for use with alias IP.

## What are VPC Flow Logs?

[VPC Flow Logs](https://cloud.google.com/vpc/docs/using-flow-logs) are a feature
where subnetworks in your network will have their traffic flow between VM
instances sampled and sent to Stackdriver; there, you can use them for a variety
of purposes including forensics and expense optimization. Only TCP and UDP
traffic is logged. Flow logging is enabled by default in this module, and can be
disabled by settings `enable_flow_logging` to false.


## Network Architecture

This network architecture is inspired by the VPC Architecture described by Ben
Whaley in his blog post [A Reference VPC Architecture](https://www.whaletech.co/2014/10/02/reference-vpc-architecture.html).
Notably, the hard distinction between "Application" and "Management" in terms of
subnetwork tiers has been removed- either can include or exclude the persistence
tier.

Instead, Whaley's "Application" networks are generally host networks with
attached service projects, and "Management" networks should be used with
services inside the same project. 

<!-- TODO(rileykarson): Expand on how the reference arch maps to GCP -->

## Gotchas

<!-- TODO(rileykarson): Add gotchas as they become apparent -->

## What IAM roles does this module configure? (unimplemented)

Given a service account, this module will enable the following IAM roles:

* 

## What services does this module enable on my project? (unimplemented)

This module will ensure the following services are active on your project:

*
