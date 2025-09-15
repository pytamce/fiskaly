# Kubernetes Deployment — Hello World App with Nginx Load Balancer

This repository demonstrates a **simple Kubernetes deployment** of a web with **Nginx as a load balancer** in front of it. 


---

## Files
```
README.md
k8s/
  ├─ hello-app-deployment.yaml
  ├─ hello-service.yaml
  ├─ nginx-conf-configmap.yaml
  ├─ nginx-deployment.yaml
  ├─ nginx-service.yaml
  └─ hpa.yaml
```

---

## Kubernetes Deployment Details

### Hello App Deployment

* **Replicas:** 2 initially.
* **Resources:** requests `cpu: 100m`, `memory: 128Mi`; limits `cpu: 500m`, `memory: 256Mi`.
* **Probes:** Liveness and readiness HTTP probes on `/` to ensure healthy routing.

### Hello Service

* Resolves allo-app pods via DNS for Nginx upstream

### Horizontal Pod Autoscaler (HPA)

* **Target:** hello-app Deployment.
* **Min replicas:** 2.
* **Max replicas:** 4.
* **Metric:** CPU utilization 70%.