GOPATH=$(shell go env GOPATH)
MAIN_FILE=main.go

all: clear download-deps build-all status

status:
	@echo Generated artifacts:
	@find ./target -type f -exec file {} \;

clear:
	@echo Removing old builds...
	@rm -rf target/
	@mkdir -p target/

build-all: build-macos build-linux build-windows

build-macos:
	@echo Building MacOS binary
	@env GOOS=darwin GOARCH=amd64 go build -o target/darwin/amd64/h2tp "${MAIN_FILE}"

build-windows:
	@echo Building Windows binary
	@env GOOS=windows GOARCH=amd64 go build -o target/windows/amd64/h2tp.exe "${MAIN_FILE}"

build-linux:
	@echo Building Linux binary
	@env GOOS=linux GOARCH=amd64 go build -o target/linux/amd64/h2tp "${MAIN_FILE}"
	@env GOOS=linux GOARCH=arm64 go build -o target/linux/arm64/h2tp "${MAIN_FILE}"
	@env GOOS=linux GOARCH=arm go build -o target/linux/arm/h2tp "${MAIN_FILE}"

download-deps:
	@go get -v -d .