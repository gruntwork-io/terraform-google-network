package test

import (
	"path/filepath"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestBastionHost(t *testing.T) {
	t.Parallel()

	testFolder := test_structure.CopyTerraformFolderToTemp(t, "..", "examples")
	terraformModulePath := filepath.Join(testFolder, "bastion-host")

	project := gcp.GetGoogleProjectIDFromEnvVar(t)
	region := gcp.GetRandomRegion(t, project, nil, nil)
	zone := gcp.GetRandomZoneForRegion(t, project, region)
	terratestOptions := createBastionHostTerraformOptions(t, strings.ToLower(random.UniqueId()), project, region, zone, terraformModulePath)
	defer terraform.Destroy(t, terratestOptions)

	terraform.InitAndApply(t, terratestOptions)

	/*
		Test SSH
	*/
	address := terraform.Output(t, terratestOptions, "address")
	googleIdentity := gcp.GetGoogleIdentityEmailEnvVar(t)

	keyPair := ssh.GenerateRSAKeyPair(t, 2048)
	key := keyPair.PublicKey

	user := googleIdentity

	defer gcp.DeleteSSHKey(t, user, key)
	gcp.ImportSSHKey(t, user, key)

	loginProfile := gcp.GetLoginProfile(t, user)
	sshUsername := loginProfile.PosixAccounts[0].Username

	bastionHost := ssh.Host{
		Hostname:    address,
		SshKeyPair:  keyPair,
		SshUserName: sshUsername,
	}

	private := FetchFromOutput(t, terratestOptions, project, "private_instance")
	privateHost := ssh.Host{
		Hostname:    private.Name,
		SshKeyPair:  keyPair,
		SshUserName: sshUsername,
	}

	sshChecks := []SSHCheck{
		// Success
		{"bastion", func(t *testing.T) { testSSHOn1Host(t, ExpectSuccess, bastionHost) }},
		{"bastion to private", func(t *testing.T) { testSSHOn2Hosts(t, ExpectSuccess, bastionHost, privateHost) }},

		// Failure
		{"private", func(t *testing.T) { testSSHOn1Host(t, ExpectFailure, privateHost) }},
	}

	// We need to run a series of parallel funcs inside a serial func in order to ensure that defer statements are ran after they've all completed
	t.Run("sshConnections", func(t *testing.T) {
		for _, check := range sshChecks {
			check := check // capture variable in local scope

			t.Run(check.Name, func(t *testing.T) {
				t.Parallel()
				check.Check(t)
			})
		}
	})
}
