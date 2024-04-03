APP=kbot
VERSION=v1.0.5
REGISTRY=alwisx
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture}  go build -v -o kbot -ldflags "-X="github.com/alwis-education/kbot/cmd.appVersion=v1.0.5

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}


clean:
	rm -rf kbot
