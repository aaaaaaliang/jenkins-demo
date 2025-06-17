# ---------- 构建阶段 ----------
FROM golang:1.23 AS builder

# 设置国内模块代理，防止 go mod download 失败
ENV GOPROXY=https://goproxy.cn,direct

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./
RUN go build -o app .

# ---------- 运行阶段 ----------
FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/app ./

EXPOSE 8080

CMD ["./app"]
