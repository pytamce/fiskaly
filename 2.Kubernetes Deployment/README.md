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
pdb.yaml                    # pod distribution budget
```

---

## Design

* **Replicas:** 2 initially.
* **Resources:** requests `cpu: 100m`, `memory: 128Mi`; limits `cpu: 500m`, `memory: 256Mi`.
* **Probes:** Liveness probes on `/healthz` and readiness probes on `/readyz`
* **Horizontal Pod Autoscaler** min: 2, max: 4, metric: CPU utilization 70%
* **PodDisruptionBudget:** minAvailable: 1
* **NGINX load balancer** upstream to `server hello-service:80`

---

## Scalability / Security / Availability & Reliability aspects
- Resilient → self-healing (via probes), safe rolling updates (via PDB), load-balanced requests.
- Scalable → auto-adjusts replicas based on CPU utilization.
- Efficient → resource requests/limits optimize scheduling and prevent cluster resource exhaustion.

---

## Deployment
```bash
cd "2.Kubernetes Deployment"
kubectl create -f .
```

---

## Test HPA
```bash
kubectl run -i --tty load-generator --image=busybox /bin/sh
while true; do wget -q -O- http://hello-service:80; done
kubectl get hpa -w
```

