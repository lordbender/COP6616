package main

import "math/rand"

// Returns an int >= min, < max
func randomInt64(min, max int64) int64 {
	return min + rand.Int63n(max-min)
}

func getArray(size int) []int64 {
	a := make([]int64, size)

	for i := 0; i < size; i++ {
		a[i] = randomInt64(0, 1000)
	}

	return a
}

func getTarget() int64 {
	return randomInt64(0, 1000)
}
