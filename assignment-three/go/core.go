package main

import (
	"math/rand"
	"time"
)

// Returns an int >= min, < max
func randomInt64() int64 {
	rand.Seed(time.Now().UTC().UnixNano())
	return rand.Int63n(10000)
}

func getArray(size int) []int64 {
	a := make([]int64, size)

	for i := 0; i < size; i++ {
		a[i] = randomInt64()
	}

	return a
}

func getTarget() int64 {
	return randomInt64()
}
