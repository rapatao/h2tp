GOPATH=$(shell go env GOPATH)
MAIN_FILE=main.go

all: clear build status

status:
	@echo Generated artifacts:
	@find ./target -type f -exec file {} \;

clear:
	@echo Removing old builds...
	@rm -rf target/

build: build-macos build-linux build-windows

build-macos: build-macos-amd64

build-macos-amd64: download-deps
	@echo Building MacOS binary
	@env GOOS=darwin GOARCH=amd64 go build -o target/darwin/amd64/h2tp "${MAIN_FILE}"

build-windows: build-windows-amd64

build-windows-amd64: download-deps
	@echo Building Windows binary
	@env GOOS=windows GOARCH=amd64 go build -o target/windows/amd64/h2tp.exe "${MAIN_FILE}"

build-linux: download-deps build-linux-amd64 build-linux-arm64 build-linux-arm

build-linux-amd64:
	@echo Building Linux/amd64 binary
	@env GOOS=linux GOARCH=amd64 go build -o target/linux/amd64/h2tp "${MAIN_FILE}"

build-linux-arm64:
	@echo Building Linux/arm64 binary
	@env GOOS=linux GOARCH=arm64 go build -o target/linux/arm64/h2tp "${MAIN_FILE}"

build-linux-arm:
	@echo Building Linux/arm binary
	@env GOOS=linux GOARCH=arm go build -o target/linux/arm/h2tp "${MAIN_FILE}"

download-deps:
	@go get -v -d .