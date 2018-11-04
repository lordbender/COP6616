package main

import "fmt"

func main() {
	const size = 100000
	var a = getArray(size)
	var target = getTarget()
	hits := 0

	for i := 0; i < size; i++ {
		if a[i] == target {
			hits++
		}
	}

	fmt.Printf("N hits => %d\n", hits)
}
