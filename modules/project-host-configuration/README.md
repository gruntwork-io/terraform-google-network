# Project Host Configuration Module

The Project Host Configuration module is used to turn a project into a ["host" project](https://cloud.google.com/vpc/docs/shared-vpc#shared_vpc_host_project_and_service_project_associations)
whose networks are "host" networks, able to be shared across multiple service projects.

## How do you use this module?

* See the [root README](/README.md) for instructions on using Terraform modules.
* See the [examples](/examples) folder for example usage.
* See [variables.tf](./variables.tf) for all the variables you can set on this module.
* See [outputs.tf](./outputs.tf) for all the variables that are outputed by this module.

## How is a "host" network different than a normal network?
A host network is a [Shared VPC](https://cloud.google.com/vpc/docs/shared-vpc) concept; shared VPC is a feature that
allows organizations to define a network inside a single project, and to share that network across multiple projects
within their organization.

Once a project enables shared VPC- becoming a "host" project- every network in that project becomes a host network that
can be shared across multiple "service" projects. The host network(s) can only be managed from the host project,
implementing the security best practice of least privilege for network administration

## What is a service project?
A service project is a project that has been attached to a host project by the host project administrators. Service
projects cannot also become host projects, and a service project may only connect to a single host project.

Service projects have first-class access to usage of host networks, and can also define their own networks. In general,
service projects should exclusively use host networks. Billing for resources in a Shared VPC network is generally
attributed to the service project. See the [service project billing](https://cloud.google.com/vpc/docs/shared-vpc#billing)
docs for details.

<!-- TODO(rileykarson): Add IAM / project services to provided project or eliminate this section -->
## What IAM roles does this module configure? (unimplemented)

Given a service account, this module will enable the following IAM roles:

* 

## What services does this module enable on my project? (unimplemented)

This module will ensure the following services are active on your project:

*
