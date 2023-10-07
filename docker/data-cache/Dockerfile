FROM alpine/git:v2.32.0
RUN --no-cache git clone https://github.com/sunmao-dx/data-cache.git /data-cache


FROM python:3.8-alpine
RUN pip install flask_restful requests pika loguru
COPY --from=0 /data-cache /data-cache

WORKDIR /data-cache
CMD ["python", "app.py"]

