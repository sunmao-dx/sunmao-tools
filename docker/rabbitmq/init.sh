#!/bin/sh

# Create Rabbitmq user
( rabbitmqctl wait --timeout 60 $RABBITMQ_PID_FILE ; \
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD 2>/dev/null ; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
rabbitmqctl set_permissions -p / $RABBITMQ_USER  ".*" ".*" ".*" ; \
rabbitmqadmin declare queue --vhost=/ name=gitee_data_processing durable=true ; \
curl --user $RABBITMQ_USER:$RABBITMQ_PASSWORD --data "@/delayed_exchange.json" --header "Content-Type: application/json" --request POST "http://127.0.0.1:15672/api/definitions" ; \
echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' completed. ***" ; \
echo "*** Log in the WebUI at port 15672 (example: http:/localhost:15672) ***") &

# $@ is used to pass arguments to the rabbitmq-server command.
# For example if you use it like this: docker run -d rabbitmq arg1 arg2,
# it will be as you run in the container rabbitmq-server arg1 arg2
echo "log.default.level = error" >> /etc/rabbitmq/conf.d/11-debug-log.conf
rabbitmq-server $@
#rabbitmq-plugins enable rabbitmq_delayed_message_exchange $@
