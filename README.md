<<<<<<< HEAD ...
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
=======
# FoodExpress with HashiCorp Vault on Kubernetes

## Prerequisites
>>>>>>> 6d5b78a (updated vault-auth.sh)

- Docker
- Kubernetes (Minikube)
- kubectl
- Helm
- Vault CLI
- Git

---

# Clone Repository

```bash
git clone https://github.com/Madhurichennupati010/Task8-vault-Food-express.git
cd Task8-vault-Food-express
```

---

# Start Minikube

```bash
minikube start --driver=docker
```

Verify Cluster

```bash
kubectl get nodes
kubectl cluster-info
```

---

# Enable Minikube Addons

```bash
minikube addons enable ingress
minikube addons enable metrics-server
minikube addons enable storage-provisioner
minikube addons enable default-storageclass
```

---

# Create Namespace

```bash
kubectl apply -f namespace.yaml
```

Verify

```bash
kubectl get ns
```

---

# Install Vault using Helm

Add Repository

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
```

Install Vault

```bash
helm install vault hashicorp/vault \
--namespace foodexpress \
--set "server.dev.enabled=true"
```

Verify

```bash
kubectl get pods -n foodexpress
```

---

# Initialize Vault (Skip in Dev Mode)

```bash
kubectl exec -it vault-0 -n foodexpress -- vault operator init
```

---

# Unseal Vault

```bash
kubectl exec -it vault-0 -n foodexpress -- vault operator unseal
```

Repeat with three unseal keys.

---

# Login to Vault

```bash
kubectl exec -it vault-0 -n foodexpress -- sh
```

```bash
vault login
```

Paste Root Token.

---

# Enable KV Secret Engine

```bash
vault secrets enable -path=secret kv-v2
```

---

# Create Secret

```bash
vault kv put secret/foodexpress \
DB_USER=root \
DB_PASSWORD=root123 \
API_KEY=myapikey
```

Verify

```bash
vault kv get secret/foodexpress
```

---

# Enable Kubernetes Authentication

```bash
vault auth enable kubernetes
```

---

# Create Token

```bash
TOKEN=$(kubectl create token vault -n foodexpress)
```

---

# Create CA Certificate

```bash
kubectl config view --raw --minify --flatten \
-o jsonpath='{.clusters[].cluster.certificate-authority-data}' \
| base64 -d > ca.crt
```

---

# Copy CA Certificate into Vault

```bash
kubectl cp ca.crt foodexpress/vault-0:/tmp/ca.crt
```

---

# Configure Kubernetes Authentication

```bash
kubectl exec -it vault-0 -n foodexpress -- sh
```

```bash
vault write auth/kubernetes/config \
token_reviewer_jwt="$TOKEN" \
kubernetes_host="https://172.30.1.2:6443" \
kubernetes_ca_cert=@/tmp/ca.crt
```

---

# Create Vault Policy

```bash
cat <<EOF > foodexpress-policy.hcl
path "secret/data/foodexpress" {
  capabilities = ["read"]
}
EOF
```

Apply Policy

```bash
vault policy write foodexpress foodexpress-policy.hcl
```

---

# Create Vault Role

```bash
vault write auth/kubernetes/role/foodexpress \
bound_service_account_names=backend-sa \
bound_service_account_namespaces=foodexpress \
policies=foodexpress \
ttl=24h
```

---

# Deploy Application

```bash
kubectl apply -f .
```

Or

```bash
kubectl apply -f kubernetes/
```

---

# Verify Resources

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
kubectl get deployments -n foodexpress
```

ReplicaSets

```bash
kubectl get rs -n foodexpress
```

ConfigMaps

```bash
kubectl get configmap -n foodexpress
```

Secrets

```bash
kubectl get secrets -n foodexpress
```

Ingress

```bash
kubectl get ingress -n foodexpress
```

PVC

```bash
kubectl get pvc -n foodexpress
```

PV

```bash
kubectl get pv
```

HPA

```bash
kubectl get hpa -n foodexpress
```

---

# Verify Vault

Vault Status

```bash
kubectl exec -it vault-0 -n foodexpress -- vault status
```

Vault Auth Methods

```bash
kubectl exec -it vault-0 -n foodexpress -- vault auth list
```

Vault Role

```bash
kubectl exec -it vault-0 -n foodexpress -- \
vault read auth/kubernetes/role/foodexpress
```

Vault Secret

```bash
kubectl exec -it vault-0 -n foodexpress -- \
vault kv get secret/foodexpress
```

---

# Check Pod Logs

Backend

```bash
kubectl logs -f deployment/backend -n foodexpress
```

Vault Agent

```bash
kubectl logs <pod-name> -c vault-agent -n foodexpress
```

Vault Init Container

```bash
kubectl logs <pod-name> -c vault-agent-init -n foodexpress
```

---

# Describe Resources

```bash
kubectl describe pod <pod-name> -n foodexpress
```

```bash
kubectl describe deployment backend -n foodexpress
```

```bash
kubectl describe service backend -n foodexpress
```

---

# Restart Deployment

```bash
kubectl rollout restart deployment/backend -n foodexpress
```

Check Rollout

```bash
kubectl rollout status deployment/backend -n foodexpress
```

---

# Scale Deployment

```bash
kubectl scale deployment backend --replicas=5 -n foodexpress
```

---

# Delete Everything

```bash
kubectl delete namespace foodexpress
```

Or

```bash
kubectl delete -f kubernetes/
```

---

# Useful Commands

Watch Pods

```bash
kubectl get pods -n foodexpress -w
```

Execute Inside Backend Pod

```bash
kubectl exec -it <backend-pod> -n foodexpress -- sh
```

Execute Inside Vault

```bash
kubectl exec -it vault-0 -n foodexpress -- sh
```

View Events

```bash
kubectl get events -n foodexpress --sort-by=.metadata.creationTimestamp
```

Check Cluster

```bash
kubectl get all -n foodexpress
```
