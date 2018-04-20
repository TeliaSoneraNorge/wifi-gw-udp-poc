# WiFi Gateway UDP (PoC)


This project is a simple implementation of a UDP server built for ingesting WiFi raw data packets from Datek (Fortinet).
The server only outputs the packets to the console, which are in turn available as a stream in CloudWatch.


## Prerequisite
> - Docker
> - npm: 5.6.0
> - node: 8.9.3



## Build

At the root of the project:

```
docker build -t di-wifi-gw .
```

## Run (locally)

```
docker run -p 33333:33333/udp di-wifi-gw
```

## Test (locally)

At the root of the project:

```
node client.js
```

Inspect the container logs

```
docker container ls
```

Output:
`<CONTAINER_ID>        <IMAGE_ID>        "pm2-docker index.js"   XX minutes ago      Up XX minutes       33333/tcp, 0.0.0.0:33333->33333/udp   <TAG>`

```
docker container logs <CONTAINER_ID>
```

The last entry should show something like:
`172.17.0.1:33556 - Data Insights Rocks!`


## Run (on the server)

Login with AWS (The EC2 is granted to connect to ECR)
```
aws ecr get-login --no-include-email --region eu-west-1
```

Get the latest docker image
```
docker pull 276208424594.dkr.ecr.eu-west-1.amazonaws.com/di-wifi-gw:latest
```

Run the latest image with logging to AWS CloudWatch
```
docker run -it --log-driver="awslogs" --log-opt awslogs-region="eu-west-1" --log-opt awslogs-group="di-wifi-gw" --log-opt awslogs-stream="log-stream" -p 33333:33333/udp 276208424594.dkr.ecr.eu-west-1.amazonaws.com/di-wifi-gw:latest
```
