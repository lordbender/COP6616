package main

import "fmt"
import "time"

// Returns an int >= min, < max
func search() {
	const size = 100000
	var a = getArray(size)
	var target = getTarget()
	hits := 0

	start := time.Now()
	for i := 0; i < size; i++ {
		if a[i] == target {
			hits++
		}
	}

	elapsed := time.Since(start)

	fmt.Printf("\t%d was located %d times in %s\n", target, hits, elapsed)
}
