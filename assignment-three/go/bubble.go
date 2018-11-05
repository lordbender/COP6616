package main

import (
	"fmt"
	"time"
)

func bubbleSort(size int) {
	var array = getArray(size)

	start := time.Now()
	for i := 0; i < size; i++ {
		for j := 0; j < size-i-1; j++ {

			if array[j] > array[j+1] {
				array[j], array[j+1] = array[j+1], array[j]
			}
		}
	}
	duration := time.Since(start)
	fmt.Printf("\n\tBubble Sort on %d numbers\n\tO(n^2) Operations\n\tRan in %s\n\n", size, duration)
}
