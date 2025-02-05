FROM golang:1.23.6-alpine@sha256:2c49857f2295e89b23b28386e57e018a86620a8fede5003900f2d138ba9c4037 as builder

WORKDIR /app
COPY . /app

RUN CGO_ENABLED=0 go build -ldflags="-w -s" -v -o app ./cmd/run

FROM alpine:latest@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]
