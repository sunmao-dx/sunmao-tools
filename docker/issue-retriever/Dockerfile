FROM alpine/git:v2.32.0
RUN git clone https://gitee.com/zichengqu/issue-retriever.git /issue-retriever

FROM golang:alpine
WORKDIR /app
#COPY ./event-retriever/ ./
COPY --from=0 /issue-retriever ./
RUN go mod download
RUN go build -o issue_retriever src/server.go


FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=1 /app ./
CMD ["./issue_retriever"]
