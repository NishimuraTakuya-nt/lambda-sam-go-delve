package main

import (
	"fmt"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
	Name    string `json:"name"`
	Message string `json:"message"`
}

type Response struct {
	Greeting string `json:"greeting"`
}

func handler(request Request) (Response, error) {
	greeting := fmt.Sprintf("Hello v2, %s! %s, %v", request.Name, request.Message, time.Now())

	return Response{
		Greeting: greeting,
	}, nil
}

func main() {
	lambda.Start(handler)
}
