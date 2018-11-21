package main

/* Al useful imports */
import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"oop/distributed"
)

// Merge merges left and right slice into newly created slice
func merge(rw http.ResponseWriter, req *http.Request) {
	// Decode the POST body
	decoder := json.NewDecoder(req.Body)
	var model distributed.MergeRequestModel
	err := decoder.Decode(&model)
	if err != nil {
		panic(err)
	}

	left := model.Left
	right := model.Right
	size, i, j := len(left)+len(right), 0, 0
	slice := make([]int, size, size)

	for k := 0; k < size; k++ {
		if i > len(left)-1 && j <= len(right)-1 {
			slice[k] = right[j]
			j++
		} else if j > len(right)-1 && i <= len(left)-1 {
			slice[k] = left[i]
			i++
		} else if left[i] < right[j] {
			slice[k] = left[i]
			i++
		} else {
			slice[k] = right[j]
			j++
		}
	}

	responseModel := distributed.MergeResponseModel{slice}

	// Parse the response model into a writable format
	resString, err := json.Marshal(responseModel)

	rw.Write(resString)
}

func squareVector(rw http.ResponseWriter, req *http.Request) {

	// Decode the POST body
	decoder := json.NewDecoder(req.Body)
	var reqModel distributed.VectorModel
	err := decoder.Decode(&reqModel)
	if err != nil {
		panic(err)
	}

	// Square the Vector
	size := len(reqModel.Vector)

	c := make([]int, size)
	for i := 0; i < size; i++ {
		val := reqModel.Vector[i]
		c[i] = val * val
	}

	// Set the index to align the response object
	// Create the response model
	resModel := distributed.VectorModel{reqModel.RowIndex, c}

	// Parse the response model into a writable format
	resString, err := json.Marshal(resModel)

	rw.Write(resString)
}

func testUp(rw http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(rw, "Server Running")
}

func main() {
	http.HandleFunc("/api/v1/running", testUp)
	http.HandleFunc("/api/v1/vector-square", squareVector)
	http.HandleFunc("/api/v1/merge", merge)

	log.Fatal(http.ListenAndServe(":8080", nil))
}
