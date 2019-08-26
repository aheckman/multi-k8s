docker build -t caliali/multi-client:lastest -t caliali/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t caliali/multi-worker:lastest -t caliali/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t caliali/multi-server:lastest -t caliali/multi-server:$SHA -f ./server/Dockerfile ./server

docker push caliali/multi-client:latest
docker push caliali/multi-worker:latest
docker push caliali/multi-server:latest

docker push caliali/multi-client:$SHA
docker push caliali/multi-worker:$SHA
docker push caliali/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=caliali/multi-server:$SHA
kubectl set image deployments/client-deployment client=caliali/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=caliali/multi-worker:$SHA

