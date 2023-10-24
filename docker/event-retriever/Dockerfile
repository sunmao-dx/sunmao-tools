FROM alpine/git:v2.32.0
RUN git clone https://github.com/sunmao-dx/EventRetriever.git /event-retriever

FROM golang:alpine
WORKDIR /app
#COPY ./event-retriever/ ./
COPY --from=0 /event-retriever ./
RUN go mod download
RUN go build -o event_retriever src/server.go


FROM alpine:3.18.4
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app ./

RUN useradd -ms /bin/bash nonrootuser
USER nonrootuser
RUN chown -R nonrootuser:nonrootuser /app

CMD ["./event_retriever"]
