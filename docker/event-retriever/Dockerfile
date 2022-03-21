FROM alpine/git:v2.32.0
RUN git clone https://gitee.com/sunmao-dx/event-retriever.git /event-retriever

FROM golang:alpine
WORKDIR /app
#COPY ./event-retriever/ ./
COPY --from=0 /event-retriever ./
RUN go mod download
RUN go build -o event_retriever src/server.go


FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app ./
CMD ["./event_retriever"]
