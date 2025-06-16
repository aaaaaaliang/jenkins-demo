# 使用官方 Go 镜像作为构建环境
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .
RUN go build -o app .

# 使用小镜像运行程序
FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]
