FROM alpine/git:v2.32.0
RUN git clone https://gitee.com/zichengqu/event-adapter.git /event-adapter

FROM golang:alpine
WORKDIR /app
#COPY ./event-retriever/ ./
COPY --from=0 /event-adapter ./
RUN go mod download
RUN go build -o event_adapter src/server.go


FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app ./
CMD ["./event_adapter"]
