package main

import (
	"fmt"
	"math/rand"
	"time"
)

// Citation: http://www.golangprograms.com/golang-program-for-implementation-of-quick-sort.html
func sorter(a []int64) []int64 {
	if len(a) < 2 {
		return a
	}

	left, right := 0, len(a)-1

	pivot := rand.Int() % len(a)

	a[pivot], a[right] = a[right], a[pivot]

	for i := range a {
		if a[i] < a[right] {
			a[left], a[i] = a[i], a[left]
			left++
		}
	}

	a[left], a[right] = a[right], a[left]

	sorter(a[:left])
	sorter(a[left+1:])

	return a
}

func quickSort(size int) {
	var array = getArray(size)

	start := time.Now()
	sorter(array)
	duration := time.Since(start)
	fmt.Printf("\n\tQuick Sort on %d numbers\n\tO((n)log(n)) Operation\n\tRan in %s\n\n", size, duration)
}
