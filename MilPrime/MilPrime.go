package main

import (
	"fmt"
	"math"
	"flag"
	"strconv"
)

func isPrime(n int) bool {
	switch {
		case n == 1: return false
		case n < 4: return true
		case n % 2 == 0: return false
		case n < 9: return true
		case n % 3 == 0: return false
	} 
	r := int(math.Sqrt(float64(n)))
	f := 5
	for f <= r {
		if (n % f) == 0 { return false }
		if (n % (f + 2)) == 0 { return false }
		f += 6
	}
	return true
}


func primeAt(limit int) int {
	count := 1
	candidate := 1
	for count < limit {
		candidate += 2
		if isPrime(candidate) { count++ }
	}
	return candidate
}

func main() {
	flag.Parse()
	num, err := strconv.Atoi(flag.Arg(0))
	if err == nil { fmt.Println(primeAt(num)) }
}

// Millionth Prime: 11.1s