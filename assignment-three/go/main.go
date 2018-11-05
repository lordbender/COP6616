package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	code := 0
	defer func() {
		os.Exit(code)
	}()

	size, err := strconv.Atoi(os.Args[1])
	option, err1 := strconv.Atoi(os.Args[2])
	if err != nil || err1 != nil {
		fmt.Println(err)
		fmt.Println(err1)
		fmt.Println("Two Arguments must be passed.")
		fmt.Println("example: ./cool 10000 [0-2]")
		code = 1
		return
	}

	if option == 0 || option == 2 {
		fmt.Println("O(n^2)")
		bubbleSort(size)
	}

	if option == 1 || option == 2 {
		fmt.Println("O((n)log(n))")
		quickSort(size)
	}
}
