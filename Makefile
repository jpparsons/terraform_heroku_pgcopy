
BINARY=restore

VERSION=1.0.0

LDFLAGS=-ldflags "-X roadmap_restores/core.Version=${VERSION}"

all:
	go build ${LDFLAGS} -o bin/${BINARY} *.go
