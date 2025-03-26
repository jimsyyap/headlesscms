FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o /app/myapp ./cmd/main.go # Adjust entrypoint

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/myapp /app/myapp
COPY config config/
COPY .env .env
CMD ["/app/myapp"]
