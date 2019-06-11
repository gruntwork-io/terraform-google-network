package test

import (
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

const KEY_PROJECT = "project"

var (
	ExpectSuccess = true
	ExpectFailure = false

	SSHMaxRetries = 10
	// we don't want to retry for too long, but we should do it at least a few times to make sure the instance is up
	SSHMaxRetriesExpectError = 3
	SSHSleepBetweenRetries   = 3 * time.Second
	SSHTimeout               = 15 * time.Second
	SSHEchoText              = "Hello World"
)

// Convenience method to fetch an instance from a reference in the output
// TODO: remove the need for project and pull it from self link directly
func FetchFromOutput(t *testing.T, options *terraform.Options, project, key string) *gcp.Instance {
	selfLink := terraform.Output(t, options, key)
	return gcp.FetchInstance(t, project, GetResourceNameFromSelfLink(selfLink))
}

// Get a name from a GCP self link
func GetResourceNameFromSelfLink(link string) string {
	parts := strings.Split(link, "/")
	return parts[len(parts)-1]
}

func getRandomRegion(t *testing.T, projectID string) string {
	approvedRegions := []string{"europe-north1", "europe-west1", "europe-west2", "europe-west3", "us-central1", "us-east1", "us-west1"}
	return gcp.GetRandomRegion(t, projectID, approvedRegions, []string{})
}
