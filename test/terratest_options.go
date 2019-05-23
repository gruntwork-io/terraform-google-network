package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func createNetworkManagementTerraformOptions(
	t *testing.T,
	uniqueId string,
	project string,
	region string,
	templatePath string,
) *terraform.Options {
	terraformVars := map[string]interface{}{
		"name_prefix": fmt.Sprintf("management-%s", uniqueId),
		"region":      region,
		"project":     project,
	}

	terratestOptions := terraform.Options{
		TerraformDir: templatePath,
		Vars:         terraformVars,
	}

	return &terratestOptions

}

func createBastionHostTerraformOptions(
	t *testing.T,
	uniqueId string,
	project string,
	region string,
	zone string,
	templatePath string,
) *terraform.Options {
	terraformVars := map[string]interface{}{
		"name_prefix": fmt.Sprintf("bastion-%s", uniqueId),
		"region":      region,
		"zone":        zone,
		"project":     project,
	}

	terratestOptions := terraform.Options{
		TerraformDir: templatePath,
		Vars:         terraformVars,
	}

	return &terratestOptions

}
