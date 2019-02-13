# Google VPC Network Modules

This repo contains modules for creating [Virtual Private Cloud (VPC) networks](https://cloud.google.com/vpc/docs/vpc)
on Google Cloud Platform (GCP) following best practices.

#### Main Modules

The primary module is:

* [vpc-network](/modules/vpc-network): Launch a secure VPC network on GCP.

Inbound traffic to instances in the network is controlled by "access tiers", a
pair of subnetwork and [network `tags`](https://cloud.google.com/vpc/docs/add-remove-network-tags).
By defining an appropriate subnetwork and tag for an instance, you'll ensure
that traffic to and from the instance is properly restricted. See
[the Access Tier table](/modules/vpc-network#access-tier) for more details.

#### Supporting Modules

There are also several supporting modules that add extra functionality on top of
network-application and network-management:

* [network-peering](/modules/network-peering): Configure peering connections 
between your networks, allowing you to limit access between environments and
reduce the risk of production workloads being compromised.

* [project-host-configuration](/modules/project-host-configuration): Configure
your project to be a "host project" whose networks can be shared across multiple
projects in the organization as part of a defense-in-depth security strategy,
and to allow service-level billing across different teams within your
organization.

<!-- TODO: Document Bastion Host, OpenVPC, Firewall modules -->

Click on each module above to see its documentation. Head over to the [examples folder](/examples) for examples.

## What's a VPC?

A [Virtual Private Cloud (VPC) network](https://cloud.google.com/vpc/docs/vpc)
or "network" is a private, isolated section of your cloud infrastructure.
Networks are a virtual version of a physically segregated network that control
connections between your resources and services both on Google Cloud and outside
of it.

Networks are global, and a single network can be used for all of your GCP
resources across all regions. Subnetworks, ranges of IP addresses within a
single region, can be used to usefully partition your private network IP space.

<!-- TODO: ## What parts of the Production Grade Infrastructure Checklist are covered by this Module? -->

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

Contributions are very welcome! Check out the [Contribution Guidelines](/CONTRIBUTING.md) for instructions.


## How is this Module versioned?

This Module follows the principles of [Semantic Versioning](http://semver.org/). You can find each new release, along
with the changelog, in the [Releases Page](../../releases).

During initial development, the major version will be 0 (e.g., `0.x.y`), which indicates the code does not yet have a
stable API. Once we hit `1.0.0`, we will make every effort to maintain a backwards compatible API and use the MAJOR,
MINOR, and PATCH versions on each release to indicate any incompatibilities.


## License

Please see [LICENSE](/LICENSE) for how the code in this repo is licensed.

Copyright &copy; 2019 Gruntwork, Inc.
