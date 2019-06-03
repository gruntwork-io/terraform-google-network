# Bastion Host Module

The Bastion Host module is used to configure a [Google Compute Engine (GCE) VM Instance](https://cloud.google.com/compute/docs/instances/)
as a bastion host or "jumpbox", allowing access to private instances inside your VPC network. 

Bastion hosts configured with this module are set up so access to the bastion host is controlled by the user's Google
identity and the GCP IAM roles it's been granted through [OS Login](https://cloud.google.com/compute/docs/oslogin/). SSH
keys for individual instances are unable to be managed by the user; instead, GCP manages access through fine-grained,
revokable IAM roles. OS Login is the recommended way to manage many users across multiple instances or projects on GCP.

## How do I SSH to the host?

You can access a VM instance through OS Login with normal SSH using your OS Login "profile" - the username and SSH key
connected to your Google identity. See [managing instance access](https://cloud.google.com/compute/docs/instances/managing-instance-access)
for a full reference.

Assuming that you've configured your default SSH key to be our OS Login key, that means you can SSH to an instance with:

```
ssh your_identity_email_address_example.com@N.N.N.N
```

### What is an OS Login profile?

OS Login profiles are made up of a username and a single well-known  and SSH key per user. Generally, this username will
take the form of the user's email with special characters replaced by underscores. So, `alice-doe@example.com` would
become `alice_doe_example_com`. Organization admin can change this username; if that's the case, users can confirm their
username with the `posixAccounts.username` field in `gcloud compute os-login describe-profile`.

The OS Login SSH key can be changed by the user with `gcloud compute os-login ssh-keys add --key-file [PUB_KEY_FILE_PATH]`.
Alternatively, OS Login profiles can be managed through the [OS Login API](https://cloud.google.com/compute/docs/oslogin/rest/)
or the GSuite [Directory API](https://developers.google.com/admin-sdk/directory/v1/reference/). See
[adding SSH keys to a user account](https://cloud.google.com/compute/docs/instances/managing-instance-access#add_oslogin_keys)
for a full reference.

## Can I configure access for users outside of my organization?

Provided a user has a Google identity - such as a GCP account or a `@gmail.com` email, you can
[configure access for external users](https://cloud.google.com/compute/docs/instances/managing-instance-access#external_user)
using the IAM role `roles/compute.osLoginExternalUser`

## If I remove a user's IAM role, when is access revoked?

When a user's IAM permissions are removed, ongoing sessions continue. When they try to access an instance using OS Login
again, their permissions will be evaluated and they will be unable to connect.
