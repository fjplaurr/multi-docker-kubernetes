docker build -t fjplaurr/multi-client:latest -t fjplaurr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fjplaurr/multi-server:latest -t fjplaurr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fjplaurr/multi-worker:latest -t fjplaurr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fjplaurr/multi-client:latest
docker push fjplaurr/multi-server:latest
docker push fjplaurr/multi-worker:latest

docker push fjplaurr/multi-client:$SHA
docker push fjplaurr/multi-server:$SHA
docker push fjplaurr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fjplaurr/multi-server:$SHA
kubectl set image deployments/client-deployment client=fjplaurr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fjplaurr/multi-worker:$SHA