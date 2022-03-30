FROM alpine/git:v2.32.0
RUN git clone https://gitee.com/zichengqu/note-retriever.git /note-retriever

FROM golang:alpine
WORKDIR /app
#COPY ./event-retriever/ ./
COPY --from=0 /note-retriever ./
RUN go mod download
RUN go build -o note_retriever src/server.go


FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app ./
CMD ["./note_retriever"]
