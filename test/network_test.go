package test

import (

	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestNetworkManagement(t *testing.T) {
	t.Parallel()

	testFolder := test_structure.CopyTerraformFolderToTemp(t, "..", "examples")
	terraformModulePath := filepath.Join(testFolder, "network-management")

	project := gcp.GetGoogleProjectIDFromEnvVar(t)
	region := gcp.GetRandomRegion(t, project, nil, nil)
	terratestOptions := createNetworkManagementTerraformOptions(t, random.UniqueId(), project, region, terraformModulePath)
	defer terraform.Destroy(t, terratestOptions)

	terraform.InitAndApply(t, terratestOptions)

	// Testing the cidr block itself is just reading the value out of the Terraform config;
	// by testing the gateway addresses, we've confirmed that the API had allocated the correct
	// block, although not necessarily the correct size.
	outputPublicGateway := terraform.Output(t, terratestOptions, "public_subnetwork_gateway")
	expectedPublicGateway := "10.0.0.1"
	if outputPublicGateway != expectedPublicGateway {
		t.Fatalf("expected a public gateway of %s but saw %s", expectedPublicGateway, outputPublicGateway)
	}

	outputPrivateGateway := terraform.Output(t, terratestOptions, "private_subnetwork_gateway")
	expectedPrivateGateway := "10.0.16.1"
	if outputPrivateGateway != expectedPrivateGateway {
		t.Fatalf("expected a public gateway of %s but saw %s", expectedPrivateGateway, outputPrivateGateway)
	}
}
