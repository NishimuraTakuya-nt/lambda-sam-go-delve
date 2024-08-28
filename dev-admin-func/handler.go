package main

import (
	"fmt"
	"math"
	"time"
)

type Handler interface {
	handler(event Event) (Response, error)
}

type handler struct {
}

func NewHandler() Handler {
	return &handler{}
}

func (h *handler) handler(event Event) (Response, error) {
	start := time.Now()

	primeCount := countPrimes(event.N)

	duration := time.Since(start)

	return Response{
		Message:    fmt.Sprintf("Counted primes up to %d", event.N),
		PrimeCount: primeCount,
		Duration:   duration,
	}, nil
}

func countPrimes(n int) int {
	count := 0
	for i := 2; i <= n; i++ {
		if isPrime(i) {
			count++
		}
	}
	return count
}

func isPrime(n int) bool {
	if n <= 1 {
		return false
	}
	for i := 2; i <= int(math.Sqrt(float64(n))); i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}
