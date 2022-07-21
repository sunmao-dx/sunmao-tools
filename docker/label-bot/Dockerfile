FROM alpine/git:v2.32.0
RUN git clone https://github.com/TECH4DX/label-bot.git /label-bot

FROM golang:alpine
WORKDIR /app
#COPY ./event-retriever/ ./
COPY --from=0 /label-bot ./
RUN go mod download
RUN go build -o label_bot src/server.go


FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app ./
CMD ["./label_bot"]