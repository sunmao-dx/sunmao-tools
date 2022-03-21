# Event platform installation guide

## Build the docker images

All Dockerfiles are in the `docker/` folder, use `docker build` command to build and tag the image:

```bash
# Assume you want to build the strategy-executor:
$ cd docker/strategy-executor/
$ docker build -t $DOCKER_REGISTRY/$MY_ORG/strategy-executor:$TAG ./
$ docker push $DOCKER_REGISTRY/$MY_ORG/strategy-executor:$TAG
```

Feel free to choose your favorite docker registry(dockerhub, huaweicloud swr...) and create the organization. You may need to login the registry before pushing.


## Replace the image values and gitee tokens
After building and pushing the images, specify the image url in the corresponding modules' k8s deployment yaml file.

```bash
# Assume you want to setup the strategy-executor's k8s deployment:
$ cd k8s-res/strategy-executor/
$ vim strategy-executor.dep.yaml
# Update the value of 'image' field to your own docker registry url
```

The event-retriever and strategy-executor read gitee token from environment, so don't forget to update the `gitee_token` env var in these two modules' deployment yaml.

Then all you have to do is set up the resources with kubectl:
```bash
# Setup rabbitmq:
$ cd k8s-res/rabbitmq
$ kubectl apply -f ./
```

## Few things to take care of

- Typically, only event-retriever is exposed to the gitee service as webhook.
- The modules' log are directed to the files under /event-platform-nfs/prod/$MODULE-log, it's recommended to mount a NFS to that path or use [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) to leverage more steady storage services like AWS S3.
