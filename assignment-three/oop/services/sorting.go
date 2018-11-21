package services

import "sync"

// merges left and right slice into newly created slice
func merge(left, right []int) []int {

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
	return slice
}

// MergeSort algorithm
func MergeSort(slice []int) []int {

	if len(slice) < 2 {
		return slice
	}
	mid := (len(slice)) / 2
	return merge(MergeSort(slice[:mid]), MergeSort(slice[mid:]))
}

// MergeSortParallel algorithm with deferment.
// Reference https://github.com/duffleit/golang-parallel-mergesort/blob/master/mergesort/mergesort.go
func MergeSortParallel(list []int, threshold int) []int {

	useThreshold := !(threshold < 0)

	size := len(list)
	middle := size / 2

	if size <= 1 {
		return list
	}

	var left, right []int

	sortInNewRoutine := size > threshold && useThreshold

	if !sortInNewRoutine {
		left = MergeSortParallel(list[:middle], threshold)
		right = MergeSortParallel(list[middle:], threshold)
	} else {
		var wg sync.WaitGroup
		wg.Add(2)

		go func() {
			defer func() { wg.Done() }()
			left = MergeSortParallel(list[:middle], threshold)

		}()

		go func() {
			defer func() { wg.Done() }()
			right = MergeSortParallel(list[middle:], threshold)
		}()

		wg.Wait()
	}

	return merge(left, right)

}
