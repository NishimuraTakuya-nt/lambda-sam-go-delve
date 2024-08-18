.PHONY: sam-build invoke lambda clean deploy deploy-sq

sam-build:
	sam build

invoke: sam-build ## Run sam local invoke for MapFileBundleFunction
	sam local invoke "DevAdminFunction" -e events/event.json

invoke-sq: sam-build ## Run sam local invoke for MapFileBundleFunction
	sam local invoke "SeqUserLambdaFunction" -e events/event.json

lambda: sam-build ## Run sam local start-lambda
	sam local start-lambda

## CI/CD
build: ## Build the Lambda function
	GOOS=linux GOARCH=amd64 go build -tags lambda.norpc -o bin/bootstrap dev-admin-func/main.go

build-sq: ## Build the Lambda function
	GOOS=linux GOARCH=amd64 go build -tags lambda.norpc -o bin/bootstrap seq-user-lambda-func/main.go

zip:
	zip -j bin/bootstrap.zip bin/bootstrap

clean:
	@rm -fr ./bin ./.aws-sam

deploy: ## AWS CLIを使用してLambda関数を更新
	aws lambda update-function-code --function-name DevAdminFunction --zip-file fileb://bin/bootstrap.zip

deploy-sq: ## AWS CLIを使用してLambda関数を更新
	aws lambda update-function-code --function-name SeqUserLambdaFunction --zip-file fileb://bin/bootstrap.zip

## -------------------------------------------------------
arm-build:
	cd dev-admin-func &&
	GOOS=darwin GOARCH=arm64 go build -gcflags="all=-N -l" -o main_local_arm

dlv:
	dlv exec --headless --listen=:5986 --api-version=2 --accept-multiclient ./main_local_armk