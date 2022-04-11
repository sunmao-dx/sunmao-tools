FROM alpine/git:v2.32.0
RUN git clone https://github.com/sunmao-dx/mindspore-event-rulehandler.git /rule-handler

FROM python:3.8.12-slim-buster
#RUN apk add g++

COPY --from=0 /rule-handler /rule-handler
WORKDIR /rule-handler

RUN pip install -r requirements.txt

CMD ["flask", "run"]
