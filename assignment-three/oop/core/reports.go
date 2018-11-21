package core

import (
	"fmt"
	"log"
	"os"
	"time"
)

// ReportModel is the base for creating the
// output related to a given experiment.
type ReportModel struct {
	ExecutionTime time.Duration
	Algorithm     string
	Complexity    string
	Size          int
}

// RunReport will create the formatted output for
// a given experiment.
func RunReport(model ReportModel) {
	hostname, _ := os.Hostname()

	fmt.Printf("\n\nReport for: %s\n", model.Algorithm)
	fmt.Printf("\tHostname          : %s\n", hostname)
	fmt.Printf("\tComplexity        : %s\n", model.Complexity)
	fmt.Printf("\tDuration of Run   : %s\n", model.ExecutionTime.String())
	fmt.Printf("\tSize of test set  : %d\n", model.Size)

	// Save the results to a file for later evaluation
	f, errF := os.OpenFile("./execution.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if errF != nil {
		log.Fatalf("Error opening file: %v", errF)
		return
	}
	defer f.Close()

	log.SetOutput(f)
	log.Printf("\n\nReport for: %s\n", model.Algorithm)
	log.Printf("\tHostname           : %s\n", hostname)
	log.Printf("\tComplexity         : %s\n", model.Complexity)
	log.Printf("\tDuration of Run    : %s\n", model.ExecutionTime.String())
	log.Printf("\tSize of test set   : %d\n", model.Size)

}
