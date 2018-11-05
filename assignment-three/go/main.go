package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	size, err := strconv.Atoi(os.Args[1])
	option, err1 := strconv.Atoi(os.Args[2])
	if err != nil || err1 != nil {
		fmt.Println(err)
		fmt.Println(err1)
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
