docker build -t evilbook/multi-client:latest -t evilbook/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t evilbook/multi-server:latest -t evilbook/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t evilbook/multi-worker:latest -t evilbook/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push evilbook/multi-client:latest
docker push evilbook/multi-server:latest
docker push evilbook/multi-worker:latest
docker push evilbook/multi-client:$SHA
docker push evilbook/multi-server:$SHA
docker push evilbook/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=evilbook/multi-server:$SHA
kubectl set image deployments/client-deployment client=evilbook/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=evilbook/multi-worker:$SHA
