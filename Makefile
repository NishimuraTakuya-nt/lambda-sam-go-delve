.PHONY: sam-build invoke lambda build zip clean

sam-build:
	sam build

invoke: ## Run sam local invoke for MapFileBundleFunction
	sam local invoke "DevAdminFunction" -e events/event.json

lambda: ## Run sam local start-lambda
	sam local start-lambda

build: ## Build the Lambda function
	GOOS=linux GOARCH=amd64 go build -tags lambda.norpc -o bin/bootstrap dev-admin-func/main.go

## デプロイ用にzip化
zip: build
	zip -j bin/bootstrap.zip bin/bootstrap

clean:
	@rm -fr ./bin ./.aws-sam

deploy: ## AWS CLIを使用してLambda関数を更新
	aws lambda update-function-code --function-name DevAdminFunction --zip-file fileb://bin/bootstrap.zip