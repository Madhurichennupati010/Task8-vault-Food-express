<<<<<<< HEAD
<<<<<<< HEAD .
# 🍔 FoodExpress - End-to-End DevOps Project..
=======
# Why do we use HashiCorp Vault?
>>>>>>> fcdcff8 (updated readme and vault role.sh)

HashiCorp Vault is used to securely store, manage, and control access to sensitive information (secrets) such as:

Database username and password
API keys
AWS Access Keys
SSH keys
TLS certificates
Tokens

Instead of storing these secrets inside application code or Kubernetes manifests, Vault stores them securely and provides them to applications only when needed.

Without Vault

Secrets might be stored in:

Source code
.env files
Kubernetes Secrets

These methods are less secure because Kubernetes Secrets are only Base64 encoded, not encrypted by default.

Example:

env:
- name: DB_PASSWORD
  value: password123

Anyone with access to the manifest can see the password.

With Vault

The application never contains the password.

The backend pod requests the secret from Vault using its Kubernetes Service Account.

Vault verifies the pod's identity and injects the secret into the pod automatically.

Example:

Vault
   ↓
DB_PASSWORD=password123
   ↓
Vault Agent
   ↓
Backend Pod

No password is stored in GitHub or Kubernetes manifests.

---

# Task 8 - FoodExpress Kubernetes Deployment with HashiCorp Vault

## Project Overview

This project demonstrates how to securely deploy the FoodExpress microservices application on Kubernetes by integrating HashiCorp Vault for secrets management.

Instead of storing sensitive information such as database credentials inside Kubernetes Secrets, the application dynamically retrieves them from Vault using the Vault Agent Injector.

---

# Architecture

                +----------------------+
                |      GitHub          |
                +----------+-----------+
                           |
                           |
                     Docker Images
                           |
                +----------v-----------+
                |    Docker Hub        |
                +----------+-----------+
                           |
                           |
                  Kubernetes Cluster
                           |
        ---------------------------------------
        |                 |                  |
        |                 |                  |
   Frontend          Backend           MySQL
        |                 |
        |                 |
        |           Vault Agent Sidecar
        |                 |
        -------------------
                 |
          HashiCorp Vault
                 |
          Secret/Data Store

---

# Technologies Used

- Docker
- Kubernetes
- Minikube
- HashiCorp Vault
- Helm
- Docker Hub
- GitHub
- Node.js
- MySQL

---

# Project Structure

```
Task8-vault-Food-express
│
├── backend/
├── frontend/
├── database/
│
├── kubernetes/
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── mysql-secret.yaml
│   ├── mysql-pv.yaml
│   ├── mysql-pvc.yaml
│   ├── mysql-deployment.yaml
│   ├── mysql-service.yaml
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── ingress.yaml
│   ├── backend-hpa.yaml
│   └── vault/
│       ├── vault-auth.sh
│       ├── vault-policy.hcl
│       ├── vault-role.sh
│       └── vault-secret.sh
│
└── README.md
```

---

# Prerequisites

Install the following:

- Docker Desktop
- Kubernetes (Minikube)
- kubectl
- Helm
- Git
- Vault CLI

Verify installation

```
docker --version
kubectl version --client
helm version
minikube version
vault version
```

---

# Step 1 - Start Minikube

```
minikube start --driver=docker
```

Verify

```
kubectl get nodes
```

Expected

```
control-plane Ready
```

---

# Step 2 - Enable Required Addons

```
minikube addons enable ingress

minikube addons enable metrics-server

minikube addons enable storage-provisioner

minikube addons enable default-storageclass
```

Verify

```
minikube addons list
```

---

# Step 3 - Create Namespace

```
kubectl apply -f kubernetes/namespace.yaml
```

Verify

```
kubectl get ns
```

---

# Step 4 - Deploy MySQL

Apply

```
kubectl apply -f kubernetes/mysql-pv.yaml

kubectl apply -f kubernetes/mysql-pvc.yaml

kubectl apply -f kubernetes/mysql-secret.yaml

kubectl apply -f kubernetes/mysql-deployment.yaml

kubectl apply -f kubernetes/mysql-service.yaml
```

Verify

```
kubectl get pods -n foodexpress

kubectl get pvc -n foodexpress

kubectl get svc -n foodexpress
```

---

# Step 5 - Deploy Backend

```
kubectl apply -f kubernetes/configmap.yaml

kubectl apply -f kubernetes/backend-deployment.yaml

kubectl apply -f kubernetes/backend-service.yaml
```

Verify

```
kubectl get deployment -n foodexpress

kubectl get pods -n foodexpress
```

---

# Step 6 - Deploy Frontend

```
kubectl apply -f kubernetes/frontend-deployment.yaml

kubectl apply -f kubernetes/frontend-service.yaml
```

Verify

```
kubectl get pods -n foodexpress
```

---

# Step 7 - Configure Ingress

```
kubectl apply -f kubernetes/ingress.yaml
```

Verify

```
kubectl get ingress -n foodexpress
```

---

# Step 8 - Configure HPA

```
kubectl apply -f kubernetes/backend-hpa.yaml
```

Verify

```
kubectl get hpa -n foodexpress
```

---

# Step 9 - Install HashiCorp Vault

Add Helm Repository

```
helm repo add hashicorp https://helm.releases.hashicorp.com

helm repo update
```

Install Vault

```
helm install vault hashicorp/vault \
--namespace foodexpress \
--set "server.dev.enabled=true"
```

Verify

```
kubectl get pods -n foodexpress
```

Expected

```
vault-0 Running
```

---

# Step 10 - Initialize Vault

Open Vault Pod

```
kubectl exec -it vault-0 -n foodexpress -- sh
```

Login

```
vault login root
```

---

# Step 11 - Enable KV Secret Engine

```
vault secrets enable -path=secret kv-v2
```

Verify

```
vault secrets list
```

---

# Step 12 - Create Secrets

```
vault kv put secret/foodexpress \
DB_HOST=mysql \
DB_USER=root \
DB_PASSWORD=password \
DB_NAME=foodexpress
```

Verify

```
vault kv get secret/foodexpress
```

---

# Step 13 - Enable Kubernetes Authentication

```
vault auth enable kubernetes
```

Verify

```
vault auth list
```

---

# Step 14 - Configure Kubernetes Authentication

Run

```
./vault-auth.sh
```

This script configures:

- Kubernetes Host
- CA Certificate
- Service Account JWT

Verify

```
vault read auth/kubernetes/config
```

---

# Step 15 - Create Vault Policy

Run

```
vault policy write foodexpress vault-policy.hcl
```

Verify

```
vault policy list
```

---

# Step 16 - Create Vault Role

Run

```
./vault-role.sh
```

Verify

```
vault read auth/kubernetes/role/foodexpress
```

---

# Step 17 - Configure Backend Deployment

The backend deployment contains Vault annotations.

Example

```
vault.hashicorp.com/agent-inject: "true"

vault.hashicorp.com/role: "foodexpress"

vault.hashicorp.com/agent-inject-secret-config: "secret/data/foodexpress"
```

Also include

```
serviceAccountName: backend-sa
```

---

# Step 18 - Restart Backend

```
kubectl rollout restart deployment backend -n foodexpress
```

Verify

```
kubectl get pods -n foodexpress
```

You should see

```
backend

vault-agent-init

vault-agent
```

---

# Step 19 - Verify Secrets

```
kubectl exec -it backend-pod-name -n foodexpress -- sh
```

Check

```
cat /vault/secrets/config
```

You should see

```
DB_HOST=mysql

DB_USER=root

DB_PASSWORD=password

DB_NAME=foodexpress
```

---

# Step 20 - Verify Application

```
kubectl get all -n foodexpress
```

Access application

```
minikube service frontend-service -n foodexpress
```

---

# Verification Commands

Pods

```
kubectl get pods -n foodexpress
```

Services

```
kubectl get svc -n foodexpress
```

Deployments

```
kubectl get deployments -n foodexpress
```

Ingress

```
kubectl get ingress -n foodexpress
```

HPA

```
kubectl get hpa -n foodexpress
```

PVC

```
kubectl get pvc -n foodexpress
```

PV

```
kubectl get pv
```

Vault

```
kubectl exec -it vault-0 -n foodexpress -- vault status
```

---

# Troubleshooting

## Backend Pod Pending

```
kubectl describe pod <pod-name> -n foodexpress
```

---

## Vault Authentication Failed

Check

```
vault read auth/kubernetes/config
```

---

## Secrets Not Injected

Verify annotations

```
kubectl describe pod backend-pod -n foodexpress
```

---

## HPA Metrics Error

Enable Metrics Server

```
minikube addons enable metrics-server
```

---

## Restart Deployments

```
kubectl rollout restart deployment backend -n foodexpress

kubectl rollout restart deployment frontend -n foodexpress
```

---

# Cleanup

Delete Application

```
kubectl delete namespace foodexpress
```

Delete Minikube

```
minikube delete
```

---

# Learning Outcomes

- Deploy applications on Kubernetes
- Configure Persistent Volumes
- Use ConfigMaps
- Configure Services
- Configure Ingress
- Configure Horizontal Pod Autoscaler
- Install HashiCorp Vault using Helm
- Configure Kubernetes Authentication
- Create Vault Policies and Roles
- Store secrets securely in Vault
- Inject secrets dynamically using Vault Agent Injector
- Deploy secure cloud-native applications

---

# Author

Madhuri Chennupati

AWS DevOps Engineer