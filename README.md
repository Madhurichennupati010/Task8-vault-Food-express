# 🍔 FoodExpress - End-to-End DevOps Project..

# 📖 Project Overview

FoodExpress is a cloud-native food ordering application deployed using modern DevOps practices. This project demonstrates containerization, orchestration, scalability, and deployment automation using Docker, Kubernetes (Minikube), AWS EC2, GitHub Actions, and Docker Hub.

This project showcases an end-to-end DevOps workflow from application containerization to Kubernetes deployment with autoscaling.

---

# 🎯 Objectives

- Containerize Frontend and Backend using Docker
- Push Docker Images to Docker Hub
- Deploy Application on Kubernetes
- Deploy MySQL using Persistent Storage
- Secure sensitive information using Kubernetes Secrets
- Manage configuration using ConfigMaps
- Implement Horizontal Pod Autoscaler
- Expose application using Kubernetes Services
- Deploy on AWS EC2 using Minikube
- Automate deployment using GitHub Actions

---

# 🏗️ Project Architecture

```
                    User
                      │
                      ▼
             Frontend Service
                      │
                      ▼
            Backend Service (API)
                      │
                      ▼
               MySQL Database
                      │
        Persistent Volume (PV)
                      │
Persistent Volume Claim (PVC)

        Kubernetes Cluster
             (Minikube)

Hosted on AWS EC2
```

---

# 🛠️ Technology Stack

| Technology | Purpose |
|------------|----------|
| AWS EC2 | Cloud Infrastructure |
| Ubuntu | Operating System |
| Docker | Containerization |
| Docker Hub | Image Registry |
| Kubernetes | Container Orchestration |
| Minikube | Local Kubernetes Cluster |
| GitHub Actions | CI/CD Pipeline |
| Node.js | Backend |
| React | Frontend |
| MySQL | Database |

---

# 📂 Project Structure

```
FoodExpress
│
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
│
├── frontend/
│   ├── Dockerfile
│   └── React Application
│
├── kubernetes/
│   ├── namespace.yaml
│   ├── config.yaml
│   ├── secret.yaml
│   ├── mysql-secret.yaml
│   ├── mysql-pv.yaml
│   ├── mysql-pvc.yaml
│   ├── mysql-deployment.yaml
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── ingress.yaml
│   └── hpa.yaml
│
└── .github/
    └── workflows/
        └── deploy.yml
```

---

# ⚙️ Docker Images

Backend

```
madhu934652/food-express-backend:latest
```

Frontend

```
madhu934652/food-express-frontend:latest
```

---

# 🚀 Deployment Workflow

```
GitHub

↓

GitHub Actions

↓

Docker Build

↓

Docker Hub

↓

AWS EC2

↓

Minikube

↓

Kubernetes

↓

FoodExpress Application
```

---

# ☁️ AWS Setup

Launch Ubuntu EC2

Install

- Docker
- Git
- kubectl
- Minikube

Start Minikube

```bash
minikube start --driver=docker
```

Enable Addons

```bash
minikube addons enable ingress

minikube addons enable metrics-server
```

---

# 🐳 Build Docker Images

Backend

```bash
docker build -t madhu934652/food-express-backend:latest .
```

Frontend

```bash
docker build -t madhu934652/food-express-frontend:latest .
```

---

# 📤 Push Images

```bash
docker login

docker push madhu934652/food-express-backend:latest

docker push madhu934652/food-express-frontend:latest
```

---

# ☸️ Kubernetes Deployment

Create Namespace

```bash
kubectl apply -f namespace.yaml
```

Deploy ConfigMap

```bash
kubectl apply -f config.yaml
```

Deploy Secrets

```bash
kubectl apply -f secret.yaml

kubectl apply -f mysql-secret.yaml
```

Deploy Storage

```bash
kubectl apply -f mysql-pv.yaml

kubectl apply -f mysql-pvc.yaml
```

Deploy MySQL

```bash
kubectl apply -f mysql-deployment.yaml
```

Deploy Backend

```bash
kubectl apply -f backend-deployment.yaml

kubectl apply -f backend-service.yaml
```

Deploy Frontend

```bash
kubectl apply -f frontend-deployment.yaml

kubectl apply -f frontend-service.yaml
```

Deploy Ingress

```bash
kubectl apply -f ingress.yaml
```

Deploy HPA

```bash
kubectl apply -f hpa.yaml
```

---

# 📊 Verify Deployment

```bash
kubectl get all -n foodexpress
```

Pods

```bash
kubectl get pods -n foodexpress
```

Services

```bash
kubectl get svc -n foodexpress
```

Deployments

```bash
kubectl get deployment -n foodexpress
```

HPA

```bash
kubectl get hpa -n foodexpress
```

---

# 📈 Horizontal Pod Autoscaler

Minimum Pods

```
2
```

Maximum Pods

```
6
```

Target CPU

```
70%
```

---

# 🔐 Kubernetes Secrets

- Database Username
- Database Password
- MySQL Root Password

---

# 📦 Persistent Storage

Persistent Volume

Persistent Volume Claim

Ensures MySQL data is retained even if the pod restarts.

---

# 🔄 CI/CD Pipeline

```
Git Push

↓

GitHub Actions

↓

Build Docker Image

↓

Push Docker Hub

↓

Deploy Kubernetes
```

---

# 🖥️ Screenshots

## AWS EC2

> Add Screenshot

---

## Docker Images

> Add Screenshot

---

## Docker Hub Repository

> Add Screenshot

---

## Kubernetes Pods

> Add Screenshot

---

## Kubernetes Services

> Add Screenshot

---

## Horizontal Pod Autoscaler

> Add Screenshot

---

## Browser Output

> Add Screenshot

---

# 🐞 Challenges Faced

✅ Docker Hub Authentication Error

✅ Large Backend Docker Image

✅ MySQL Secret Configuration Error

✅ CreateContainerConfigError

✅ Backend Database Connection Issues

✅ NodePort Browser Access

---

# 💡 Solutions

- Optimized Dockerfile
- Used Kubernetes Secrets
- Configured ConfigMaps
- Created Persistent Storage
- Used Resource Requests & Limits
- Added Health Probes
- Configured HPA

---

# 🎓 Learning Outcomes

- Docker Containerization
- Kubernetes Deployments
- ConfigMaps
- Secrets
- Persistent Volumes
- Persistent Volume Claims
- Horizontal Pod Autoscaler
- Services
- Ingress
- Docker Hub
- GitHub Actions
- AWS EC2
- Minikube

---

# 🚀 Future Enhancements

- Amazon EKS
- Terraform
- Helm Charts
- ArgoCD
- Prometheus
- Grafana
- NGINX Ingress
- SSL/TLS
- Monitoring
- Logging

---

# 👩‍💻 Author

**Madhuri Chennupati**

DevOps Engineer

GitHub: https://github.com/<your-github-username>

LinkedIn: https://linkedin.com/in/<your-linkedin-profile>

---

# ⭐ If you found this project useful

Please give it a ⭐ on GitHub!

---

## 📜 License

This project is licensed under the MIT License.
