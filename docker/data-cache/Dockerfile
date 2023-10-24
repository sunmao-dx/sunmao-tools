FROM alpine/git:v2.32.0
RUN git clone https://github.com/sunmao-dx/data-cache.git /data-cache


FROM python:3.8-alpine
RUN pip install flask_restful requests pika loguru
COPY --from=0 /data-cache /data-cache

WORKDIR /data-cache

RUN adduser --disabled-password --gecos '' nonrootuser
RUN chown -R nonrootuser:nonrootuser /data-cache
USER nonrootuser

CMD ["python", "app.py"]

