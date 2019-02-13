package test

import (

	"path/filepath"
	"strings"
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
	terratestOptions := createNetworkManagementTerraformOptions(t, strings.ToLower(random.UniqueId()), project, region, terraformModulePath)
	defer terraform.Destroy(t, terratestOptions)

	terraform.InitAndApply(t, terratestOptions)

	// Guarantee that we see expected values from state
	var stateValues = []struct {
		outputKey  string
		expectedValue string

		// With two string insertion points
		message string
	}{
		// Testing the cidr block itself is just reading the value out of the Terraform config;
		// by testing the gateway addresses, we've confirmed that the API had allocated the correct
		// block, although not necessarily the correct size.
		{"public_subnetwork_gateway", "10.0.0.1", "expected a public gateway of %s but saw %s"},
		{"private_subnetwork_gateway", "10.0.16.1", "expected a public gateway of %s but saw %s"},

		// Network tags as interpolation targets
		{"public", "public", "expected a tag of %s but saw %s"},
		{"private", "private", "expected a tag of %s but saw %s"},
		{"private_persistence", "private-persistence", "expected a tag of %s but saw %s"},
	}

	for _, tt := range stateValues {
		t.Run(tt.outputKey, func(t *testing.T) {
			value, err := terraform.OutputE(t, terratestOptions, tt.outputKey)
			if err != nil {
				t.Errorf("could not find %s in outputs: %s", tt.outputKey, err)
			}

			if value != tt.expectedValue {
				t.Errorf(tt.message, tt.expectedValue, value)
			}
		})
	}
}
