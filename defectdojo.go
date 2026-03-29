package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/blackaichi/go-defectdojo/defectdojo"
)

type datas struct {
	filePath          string
	EngagementName    string
	ScanType          string
	version           string
	gitlab_buildId    string
	gitlab_branchTag  string
	gitlab_commitHash string
	reponame          string
}

func files(filePath string) string {
	cwd, err := os.Getwd()
	if err != nil {
		log.Fatalf("The error is %v\n", err)
	}

	// Join the current working directory with the file path
	fullPath := filepath.Join(cwd, filePath)

	return fullPath
}

func importscan(data datas) defectdojo.ImportScan {
	return defectdojo.ImportScan{
		MinimumSeverity:   ptrString("Info"),
		Active:            ptrBool(true),
		Verified:          ptrBool(true),
		File:              &data.filePath,
		EngagementName:    &data.EngagementName,
		ScanType:          &data.ScanType,
		Environment:       ptrString("Development"),
		AutoCreateContext: ptrBool(true),
		ProductName:       &data.reponame,
		ProductTypeName:   ptrString("Research and Development"),
		Version:           &data.version,
		BuildId:           &data.gitlab_buildId,
		CommitHash:        &data.gitlab_commitHash,
		BranchTag:         &data.gitlab_branchTag,
	}
}

func main() {

	//File Path of Your report
	//If you add Another Report You need to Add file path and also DataList
	kics_file_path := files("kics_scan/kics-results.json")

	// Retrieve the GitLab CI/CD environment variables
	reponame := os.Getenv("CI_PROJECT_NAME")
	version := os.Getenv("VERSION")
	gitlab_buildId := os.Getenv("GITLAB_BUILD_ID")
	gitlab_commitHash := os.Getenv("GITLAB_COMMIT_HASH")
	gitlab_branchTag := os.Getenv("GITLAB_BRANCH_TAG")

	// User Auth
	url := os.Getenv("DEFECTDOJO_URL")
	authorizedToken := os.Getenv("DEFECTDOJO_TOKEN")
	EngagementNamed := reponame + "_" + version

	// Define multiple data structs
	dataList := []datas{
		{
			filePath:          kics_file_path,
			EngagementName:    EngagementNamed,
			ScanType:          "KICS Scan",
			version:           version,
			gitlab_buildId:    gitlab_buildId,
			gitlab_commitHash: gitlab_commitHash,
			gitlab_branchTag:  gitlab_branchTag,
			reponame:          reponame,
		},
	}

	// Creating the Client
	dj, err := defectdojo.NewDojoClient(url, authorizedToken, nil)
	if err != nil {
		log.Fatalf("Failed to create DefectDojo client: %v", err)
	}

	// Condition for failing the unwanted report upload.

	fileuploadcondition := false

	// Looping the Data
	for _, data := range dataList {
		// Check if the file exists
		if _, err := os.Stat(data.filePath); os.IsNotExist(err) {
			log.Fatalf("File does not exist: %v", err)
			continue
		}

		fileuploadcondition = true
		// Import the scan
		scan := importscan(data)

		// Use the Create method from the ImportScan service
		_, err := dj.ImportScan.Create(context.Background(), &scan)
		if err != nil {
			// Print error details
			fmt.Printf("Failed to import scan results for %s: %v\n", data.filePath, err)
		}
	}
	
	// Give as Output if No file is founded.
	if !fileuploadcondition {
		fmt.Println("No file Path has not been Founded")
	}

}

func ptrString(s string) *string {
	return &s
}

func ptrBool(b bool) *bool {
	return &b
}

// Safely dereference a string pointer, returning "<nil>" if the pointer is nil
func safeString(s *string) string {
	if s == nil {
		return "<nil>"
	}
	return *s
}

// Safely dereference a bool pointer, returning "<nil>" if the pointer is nil
func safeBool(b *bool) string {
	if b == nil {
		return "<nil>"
	}
	return fmt.Sprintf("%v", *b)
}
