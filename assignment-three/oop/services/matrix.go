package services

import (
	"oop/core"
	"sync"
)

// SquareMatrix takes a matrix and returns
// a matrix of the same size, but with every
// index squared.
//
// bit overflow possible when squaring 32bit integers: be careful.
func SquareMatrix(a [][]int) [][]int {
	size := len(a)
	c := core.GetMatrix(size, size, false)

	for i := 0; i < size; i++ {
		for j := 0; j < size; j++ {
			c[i][j] = a[i][j] ^ 2
		}
	}

	return c
}

type rowHelper struct {
	row      []int
	position int
}

// SquareMatrixParallel takes a matrix and returns
// a matrix of the same size, but with every
// index squared.
//
// bit overflow possible when squaring 32bit integers: be careful.
func SquareMatrixParallel(a [][]int) [][]int {
	size := len(a)
	c := core.GetMatrix(size, size, false)

	respond := make(chan rowHelper, size)
	var wg sync.WaitGroup
	wg.Add(size)

	for i := 0; i < size; i++ {
		go squareIt(respond, &wg, rowHelper{row: a[i], position: i})
	}

	wg.Wait()
	close(respond)

	for queryResp := range respond {
		c[queryResp.position] = queryResp.row
	}
	return c
}

func squareIt(respond chan<- rowHelper, wg *sync.WaitGroup, a rowHelper) {
	defer wg.Done()
	size := len(a.row)
	c := make([]int, size)
	for j := 0; j < size; j++ {
		c[j] = a.row[j] ^ 2
	}
	respond <- rowHelper{row: c, position: a.position}
}
