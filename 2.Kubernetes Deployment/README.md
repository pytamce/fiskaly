# ☸️ Kubernetes Deployment — Hello World App with Nginx Load Balancer

This repository demonstrates a **simple Kubernetes deployment** of a web application with **Nginx as a load balancer** in front of it. 


---

## Task
Present an example of manifests to arrange a simple Kubernetes deployment with the following:
* The simple web application built in previous task, configured to launch at least 2 replicas, and say maximum 4 in case of higher load.
* In front of the application use nginx as a load balancer.
* Please provide yaml manifests with all properties that seem necessary for a proper, secure deployment, with resources scaled as you feel necessary.


---

## Files

```
README.md
hello-app-deployment.yaml   # hello app application
hello-service.yaml          # hello app service
nginx-conf-configmap.yaml   # config map to use nginx as a load balancer
nginx-deployment.yaml       # nginx deployment for LB
nginx-service.yaml          # nginx service for LB       
hpa.yaml                    # horizontal autoscaller
```


---

## Kubernetes Deployment Details

### Hello App Deployment

* **Replicas:** 2 initially.
* **Resources:** requests `cpu: 100m`, `memory: 128Mi`; limits `cpu: 500m`, `memory: 256Mi`.
* **Probes:** Liveness and readiness HTTP probes on `/` to ensure healthy routing.

### Hello Service

* Resolves all hello-app pods via DNS for Nginx upstream

### Horizontal Pod Autoscaler (HPA)

* **Target:** hello-app Deployment.
* **Min replicas:** 2.
* **Max replicas:** 4.
* **Metric:** CPU utilization 70%.

### Test on minikube
```bash
minikube start --driver=docker
minikube addons enable metrics-server
kubectl create -f .
minikube service nginx-lb-service
kubectl run -i --tty load-generator --image=busybox /bin/sh
while true; do wget -q -O- http://hello-service:80; done
kubectl get hpa -w
```

