FROM golang:1.8 AS builder
MAINTAINER mlabouardy <mohamed@labouardy.com>
WORKDIR /go/src/github.com/mlabouardy/swaggymnia
COPY . .
RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o swaggymnia .

FROM alpine:latest
WORKDIR /root
COPY --from=builder /go/src/github.com/mlabouardy/swaggymnia/swaggymnia .
VOLUME ["/root"]
CMD ["/root/swaggymnia"]
