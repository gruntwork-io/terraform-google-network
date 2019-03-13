# Bastion Host Module

The Bastion Host module is used to configure a [Google Compute Engine (GCE) VM Instance](https://cloud.google.com/compute/docs/instances/)
as a bastion host or "jumpbox", allowing access to private instances inside your VPC network. 

Bastion hosts configured with this module are set up so access to the bastion host is controlled by the user's Google
identity and the GCP IAM roles it's been granted through [OS Login](https://cloud.google.com/compute/docs/oslogin/). SSH
keys are unable to be managed by the user; instead, GCP manages access through fine-grained, revokable IAM roles. OS
Login is is the recommended way to manage many users across multiple instances or projects on GCP.

## Can I configure access for users outside of my organization?

Provided a user has a Google identity- such as a GCP account, or an `@gmail.com` email- you can
[configure access for external users](https://cloud.google.com/compute/docs/instances/managing-instance-access#external_user)
using the IAM role `roles/compute.osLoginExternalUser`

## If I remove a user's IAM role, when is access revoked?

When a user's IAM permissions are removed, ongoing sessions continue. When they try to access an instance using OS Login
again, their permissions will be evaluated and they will be unable to connect.
