package main

import (
	"fmt"
	"time"
)

func transpose(x [][]int64) [][]int64 {
	out := make([][]int64, len(x[0]))
	for i := 0; i < len(x); i++ {
		for j := 0; j < len(x[0]); j++ {
			out[j] = append(out[j], x[i][j])
		}
	}
	return out
}

func dot(x, y [][]int64) string {
	out := make([][]int64, len(x))
	start := time.Now()
	for i := 0; i < len(x); i++ {
		for j := 0; j < len(y); j++ {
			if len(out[i]) < 1 {
				out[i] = make([]int64, len(y))
			}
			out[i][j] += x[i][j] * y[j][i]
		}
	}
	elapsed := time.Since(start)
	return elapsed.String()
}

func multMatrix(size int) {
	X := getMatrix(size)
	w := getMatrix(size)

	duration := dot(X, transpose(w))

	fmt.Printf("\n\tMatrix Multiplication\n\tO(n^3) Operation\n\tRan in %s", duration)
}
