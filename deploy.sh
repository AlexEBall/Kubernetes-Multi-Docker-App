docker build -t alexeball/fib-calc-client:latest -t alexeball/fib-calc-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexeball/fib-calc-server:latest -t alexeball/fib-calc-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexeball/fib-calc-worker:latest -t alexeball/fib-calc-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexeball/fib-calc-client:latest
docker push alexeball/fib-calc-server:latest
docker push alexeball/fib-calc-worker:latest

docker push alexeball/fib-calc-client:$SHA
docker push alexeball/fib-calc-server:$SHA
docker push alexeball/fib-calc-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexeball/fib-calc-server:$SHA
kubectl set image deployments/client-deployment client=alexeball/fib-calc-client:$SHA
kubectl set image deployments/worker-deployment worker=alexeball/fib-calc-worker:$SHA