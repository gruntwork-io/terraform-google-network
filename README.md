[![Maintained by Gruntwork.io](https://img.shields.io/badge/maintained%20by-gruntwork.io-%235849a6.svg)](https://gruntwork.io/?ref=repo_google_network)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/gruntwork-io/terraform-google-network.svg?label=latest)](https://github.com/gruntwork-io/terraform-google-network/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)
# Google VPC Network Modules

This repo contains modules for creating [Virtual Private Cloud (VPC) networks](https://cloud.google.com/vpc/docs/vpc) on
Google Cloud Platform (GCP) following best practices.

## Quickstart

If you want to quickly spin up a VPC Network in GCP, you can run the example that is in the root of this repo. Check out
[network-management example documentation](https://github.com/gruntwork-io/terraform-google-network/blob/master/examples/network-management)
for instructions.

## What's in this repo

This repo has the following folder structure:

* [root](https://github.com/gruntwork-io/terraform-google-network/tree/master): The root folder contains an example of how
  to deploy a service-agnostic "management" VPC network in GCP. See [network-management](https://github.com/gruntwork-io/terraform-google-network/blob/master/examples/network-management)
  for the documentation.

* [modules](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules): This folder contains the
  main implementation code for this Module, broken down into multiple standalone submodules.

  The primary module is:

    * [vpc-network](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/vpc-network): Launch a
    secure VPC network on GCP.

    Inbound traffic to instances in the network is controlled by "access tiers", a pair of subnetwork and
    [network `tags`](https://cloud.google.com/vpc/docs/add-remove-network-tags). By defining an appropriate subnetwork
    and tag for an instance, you'll ensure that traffic to and from the instance is properly restricted. See
    [the Access Tier table](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/vpc-network#access-tier)
    for more details.

    There are also several supporting modules that add extra functionality on top of `vpc-network`:

    * [network-peering](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/network-peering):
    Configure peering connections between your networks, allowing you to limit access between environments and reduce
    the risk of production workloads being compromised.

    * [project-host-configuration](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/project-host-configuration):
    Configure your project to be a "host project" whose networks can be shared across multiple projects in the
    organization as part of a defense-in-depth security strategy, and to allow service-level billing across different
    teams within your organization.

    * [network-firewall](https://github.com/gruntwork-io/terraform-google-network/tree/master/modules/network-firewall):
    Configures the firewall rules expected by the `vpc-network` module.

* [examples](https://github.com/gruntwork-io/terraform-google-network/tree/master/examples): This folder contains
  examples of how to use the submodules.

* [test](https://github.com/gruntwork-io/terraform-google-network/tree/master/test): Automated tests for the submodules
  and examples.

## What's a VPC?

A [Virtual Private Cloud (VPC) network](https://cloud.google.com/vpc/docs/vpc) or "network" is a private, isolated
section of your cloud infrastructure. Networks are a virtual version of a physically segregated network that control
connections between your resources and services both on Google Cloud and outside of it.

Networks are global, and a single network can be used for all of your GCP resources across all regions. Subnetworks,
ranges of IP addresses within a single region, can be used to usefully partition your private network IP space.

## What's a Module?

A Module is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such
as a database or server cluster. Each Module is written using a combination of [Terraform](https://www.terraform.io/)
and scripts (mostly bash) and include automated tests, documentation, and examples. It is maintained both by the open
source community and companies that provide commercial support.

Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse
existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself,
you can leverage the work of the Module community to pick up infrastructure improvements through
a version number bump.

## Who maintains this Module?

This Module and its Submodules are maintained by [Gruntwork](http://www.gruntwork.io/). If you are looking for help or
commercial support, send an email to
[support@gruntwork.io](mailto:support@gruntwork.io?Subject=GKE%20Module).

Gruntwork can help with:

* Setup, customization, and support for this Module.
* Modules and submodules for other types of infrastructure, such as VPCs, Docker clusters, databases, and continuous
  integration.
* Modules and Submodules that meet compliance requirements, such as HIPAA.
* Consulting & Training on AWS, Terraform, and DevOps.


## How do I contribute to this Module?

Contributions are very welcome! Check out the [Contribution Guidelines](https://github.com/gruntwork-io/terraform-google-network/blob/master/CONTRIBUTING.md)
for instructions.


## How is this Module versioned?

This Module follows the principles of [Semantic Versioning](http://semver.org/). You can find each new release, along
with the changelog, in the [Releases Page](https://github.com/gruntwork-io/terraform-google-network/releases).

During initial development, the major version will be 0 (e.g., `0.x.y`), which indicates the code does not yet have a
stable API. Once we hit `1.0.0`, we will make every effort to maintain a backwards compatible API and use the MAJOR,
MINOR, and PATCH versions on each release to indicate any incompatibilities.


## License

Please see [LICENSE](https://github.com/gruntwork-io/terraform-google-network/blob/master/LICENSE) for how the code in
this repo is licensed.

Copyright &copy; 2019 Gruntwork, Inc.
