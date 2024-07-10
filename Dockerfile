FROM golang:1.22.4-alpine as builder

WORKDIR /journey

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -o /journey/bin/journey ./cmd/journey/journey.go

FROM scratch

WORKDIR /journey

COPY --from=builder /journey/bin/journey .

EXPOSE 8080
ENTRYPOINT [ "./journey" ]



