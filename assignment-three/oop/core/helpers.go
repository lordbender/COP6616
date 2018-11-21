package core

import (
	"math/rand"
	"time"
)

// GetArray creates an Array of random integers of size n
// Where n is supplied by the requestor.
func GetArray(size int) []int {
	rand.Seed(time.Now().UTC().UnixNano())

	a := make([]int, size)

	for i := 0; i < size; i++ {
		a[i] = rand.Int()
	}

	return a
}

// GetMatrix creates a 2d matrix.
func GetMatrix(dx, dy int, fillIt bool) [][]int {
	rand.Seed(time.Now().UTC().UnixNano())
	a := make([][]int, dy)
	for i := range a {
		a[i] = make([]int, dx)
	}

	if fillIt {
		for i := 0; i < dy; i++ {
			for j := 0; j < dx; j++ {
				a[i][j] = rand.Int()
			}
		}
	}
	return a
}
