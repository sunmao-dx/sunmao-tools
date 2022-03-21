FROM alpine/git:v2.32.0
RUN git clone https://gitee.com/sunmao-dx/strategy-executor.git /strategy-executor

FROM golang:alpine
WORKDIR /app
COPY --from=0 /strategy-executor ./
RUN go mod download
COPY . .
#CMD ["go", "run", "src/server.go"]
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app ./src/server.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app/app ./
COPY --from=1 /app/src/data/repo.json ./src/data/repo.json
CMD ["./app"]

