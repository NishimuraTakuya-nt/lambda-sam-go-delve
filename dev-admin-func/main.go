package main

import (
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	N int `json:"n"`
}

type Response struct {
	Message    string        `json:"message"`
	PrimeCount int           `json:"primeCount"`
	Duration   time.Duration `json:"duration"`
}

func main() {
	h := NewHandler()
	lambda.Start(h.handler)
}
