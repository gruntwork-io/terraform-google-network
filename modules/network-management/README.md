# Management Network Module

The Management Network module creates a [Virtual Private Cloud (VPC) network](https://cloud.google.com/vpc/docs/using-vpc)
meant to house an in-house application or service used to manage other
environments, such as a DevOps tool like Jenkins. By contrast, an [Application Network](../network-management)
should be used to house applications or services running in environments like
`staging` or `production`.

Generally, you should use a single management network to run your internal
services, peering to your application networks.

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

## Subnetwork Tiers

<!-- TODO(rileykarson): Expand more thoroughly on tier capabilities -->
An application network defines these "tiers" of subnetworks;

* `public` - accessible from the public internet

* `private` - only accessible from your network or private Google services

## Network Architecture

This network architecture is inspired by the VPC Architecture described by Ben
Whaley in his blog post [A Reference VPC Architecture](https://www.whaletech.co/2014/10/02/reference-vpc-architecture.html).

<!-- TODO(rileykarson): Expand on how the reference arch maps to GCP -->

## Gotchas

<!-- TODO(rileykarson): Add gotchas as they become apparent -->

## What IAM roles does this module configure? (unimplemented)

Given a service account, this module will enable the following IAM roles:

* 

## What services does this module enable on my project? (unimplemented)

This module will ensure the following services are active on your project:

*
