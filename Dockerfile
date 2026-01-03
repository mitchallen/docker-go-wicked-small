# Build Stage
FROM golang:1.22 AS builder

WORKDIR /app

# Create Go program directly inside the Docker image
RUN cat << 'EOF' > main.go
package main

import (
    "fmt"
)

func main() {
    fmt.Println("Hello from a tiny Go Docker image!")
}
EOF

# Build a static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o app main.go

# Runtime Stage (tiny!)
FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]
