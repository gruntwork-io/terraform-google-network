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

	//os.Setenv("SKIP_bootstrap", "true")
	//os.Setenv("SKIP_deploy", "true")
	//os.Setenv("SKIP_ssh_tests", "true")
	//os.Setenv("SKIP_teardown", "true")

	_examplesDir := test_structure.CopyTerraformFolderToTemp(t, "../", "examples")
	exampleDir := filepath.Join(_examplesDir, "bastion-host")

	test_structure.RunTestStage(t, "bootstrap", func() {
		project := gcp.GetGoogleProjectIDFromEnvVar(t)
		region := getRandomRegion(t, project)
		zone := gcp.GetRandomZoneForRegion(t, project, region)

		terraformOptions := createBastionHostTerraformOptions(t, strings.ToLower(random.UniqueId()), project, region, zone, exampleDir)

		test_structure.SaveTerraformOptions(t, exampleDir, terraformOptions)
		test_structure.SaveString(t, exampleDir, KEY_PROJECT, project)
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, exampleDir)
		terraform.Destroy(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "deploy", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, exampleDir)
		terraform.InitAndApply(t, terraformOptions)
	})

	/*
		Test SSH
	*/
	test_structure.RunTestStage(t, "ssh_tests", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, exampleDir)
		project := test_structure.LoadString(t, exampleDir, KEY_PROJECT)

		address := terraform.Output(t, terraformOptions, "address")
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

		private := FetchFromOutput(t, terraformOptions, project, "private_instance")
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
	})

}
