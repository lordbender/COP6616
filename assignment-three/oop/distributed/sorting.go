package distributed

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"sync"
)

var i int = 0

func merge(mergeModel MergeRequestModel, hostsfile bool) MergeResponseModel {

	var response MergeResponseModel
	results := make(chan int, 1)
	errors := make(chan error, 1)

	var wg sync.WaitGroup
	wg.Add(1)

	go func() {
		defer wg.Done()
		url := ""
		if !hostsfile {
			url = "http://" + root + ":8080/api/v1/merge"
		} else {
			url = "http://" + getNextHost(i) + ":8080/api/v1/merge"
		}
		i++
		jsonValue, _ := json.Marshal(mergeModel)
		response, err := http.Post(url, "application/json", bytes.NewBuffer(jsonValue))

		if err != nil {
			log.Printf("The HTTP request failed with error %s\n", err)
			panic(err)
		} else {
			data, _ := ioutil.ReadAll(response.Body)
			// Marshal the results into an object

			if errR := json.Unmarshal(data, &response); err != nil {
				log.Printf("The HTTP request failed with error %s\n", errR)
				panic(errR)
			}
		}
	}()
	// here we wait in other goroutine to all jobs done and close the channels
	go func() {
		wg.Wait()
		close(results)
		close(errors)
	}()
	for err := range errors {
		// here error happend u could exit your caller function
		println(err.Error())
	}
	for res := range results {
		println("--------- ", res, " ------------")
	}
	return response
}

// MergeSortDistributed algorithm with deferment.
// Reference https://github.com/duffleit/golang-parallel-mergesort/blob/master/mergesort/mergesort.go
func MergeSortDistributed(list []int, threshold int, hostsfile bool) []int {

	useThreshold := !(threshold < 0)

	size := len(list)
	middle := size / 2

	if size <= 1 {
		return list
	}

	var left, right []int

	sortInNewRoutine := size > threshold && useThreshold

	if !sortInNewRoutine {
		left = MergeSortDistributed(list[:middle], threshold, hostsfile)
		right = MergeSortDistributed(list[middle:], threshold, hostsfile)
	} else {
		var wg sync.WaitGroup
		wg.Add(2)

		go func() {
			defer func() { wg.Done() }()
			left = MergeSortDistributed(list[:middle], threshold, hostsfile)

		}()

		go func() {
			defer func() { wg.Done() }()
			right = MergeSortDistributed(list[middle:], threshold, hostsfile)
		}()

		wg.Wait()
	}

	// Distribute here
	request := MergeRequestModel{left, right}
	response := merge(request, hostsfile)

	return response.Merged
}

// func mergeIt(respond chan<- mergeModel, a mergeModel, url string) {
// 	size := len(a.row)
// 	c := make([]int, size)

// 	for j := 0; j < size; j++ {
// 		jsonData := VectorModel{a.position, a.row}
// 		jsonValue, _ := json.Marshal(jsonData)

// 		response, err := http.Post(url, "application/json", bytes.NewBuffer(jsonValue))
// 		if err != nil {
// 			fmt.Printf("The HTTP request failed with error %s\n", err)
// 		} else {
// 			data, _ := ioutil.ReadAll(response.Body)
// 			// Marshal the results into an object
// 			var obj VectorModel
// 			if err := json.Unmarshal(data, &obj); err != nil {
// 				panic(err)
// 			}
// 			c = obj.Vector
// 		}
// 	}
// 	respond <- rowHelper{row: c, position: a.position}
// }
