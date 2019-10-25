docker build -t kgrdocker/multi-client:latest -t kgrdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kgrdocker/multi-server:latest -t kgrdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kgrdocker/multi-worker:latest -t kgrdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kgrdocker/multi-client:latest
docker push kgrdocker/multi-server:latest
docker push kgrdocker/multi-worker:latest

docker push kgrdocker/multi-client:$SHA
docker push kgrdocker/multi-server:$SHA
docker push kgrdocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kgrdocker/multi-server:$SHA
kubectl set image deployments/client-deployment server=kgrdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment server=kgrdocker/multi-worker:$SHA


