# ☸️ Kubernetes Deployment — Hello World App with Nginx Load Balancer

This repository demonstrates a **simple Kubernetes deployment** of a web application with **Nginx as a load balancer** in front of it. 


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