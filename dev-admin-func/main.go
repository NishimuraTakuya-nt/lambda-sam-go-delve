package main

import (
	"fmt"

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
	greeting := fmt.Sprintf("Hello v1, %s! %s", request.Name, request.Message)

	return Response{
		Greeting: greeting,
	}, nil
}

func main() {
	lambda.Start(handler)
}
