package distributed

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"math"
	"net/http"
)

const root string = "127.0.0.1"

func hosts() []string {
	return []string{
		"compute-0-0",
		"compute-0-1",
		"compute-0-2",
		"compute-0-3",
		"compute-0-4",
		"compute-0-5",
		"compute-0-6",
		"compute-0-7",
		"compute-0-8",
		"compute-0-9",
		"compute-0-10",
		"compute-0-11",
		"compute-0-12",
	}
}

func getNextHost(i int) string {
	hosts := hosts()
	size := len(hosts)
	var iPrime int = 0

	if i < size {
		iPrime = i
	} else {
		iPrime = int(math.Mod(float64(i), 13))
	}
	return hosts[iPrime]
}

type rowHelper struct {
	row      []int
	position int
}

// SquareMatrix will return a copy of a matrix, with every index's value squared.
func SquareMatrix(a [][]int, hostsfile bool) {
	size := len(a[0])
	maxNbConcurrentGoroutines := func() int {
		if hostsfile {
			return 12
		} else {
			return 1
		}
	}()
	concurrentGoroutines := make(chan struct{}, maxNbConcurrentGoroutines)

	// Fill the dummy channel with maxNbConcurrentGoroutines empty struct.
	for i := 0; i < maxNbConcurrentGoroutines; i++ {
		concurrentGoroutines <- struct{}{}
	}

	// Semaphores
	done := make(chan bool)
	waitForAllJobs := make(chan bool)

	// Here is where the result will go
	result := make([][]int, size)

	// burstLimit := 50
	respond := make(chan rowHelper, size)

	go func() {
		for i := 0; i < size; i++ {
			<-done
			// Say that another goroutine can now start.
			concurrentGoroutines <- struct{}{}
		}
		// We have collected all the jobs, the program
		// can now terminate
		waitForAllJobs <- true
	}()

	for i := 0; i < size; i++ {
		<-concurrentGoroutines
		go func(i int) {
			var url string = ""
			if !hostsfile {
				url = "http://" + root + ":8080/api/v1/vector-square"
			} else {
				url = "http://" + getNextHost(i) + ":8080/api/v1/vector-square"
			}
			squareIt(respond, rowHelper{row: a[i], position: i}, url)
			done <- true
		}(i)
	}

	// Wait for all jobs to finish
	<-waitForAllJobs

	close(respond)
	for queryResp := range respond {
		result[queryResp.position] = queryResp.row
	}
}

func squareIt(respond chan<- rowHelper, a rowHelper, url string) {
	size := len(a.row)
	c := make([]int, size)

	for j := 0; j < size; j++ {
		jsonData := VectorModel{a.position, a.row}
		jsonValue, _ := json.Marshal(jsonData)

		response, err := http.Post(url, "application/json", bytes.NewBuffer(jsonValue))
		if err != nil {
			fmt.Printf("The HTTP request failed with error %s\n", err)
		} else {
			data, _ := ioutil.ReadAll(response.Body)
			// Marshal the results into an object
			var obj VectorModel
			if err := json.Unmarshal(data, &obj); err != nil {
				panic(err)
			}
			c = obj.Vector
		}
	}
	respond <- rowHelper{row: c, position: a.position}
}
