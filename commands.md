kubectl get pods -n foodexpress

vault status

vault operator init

vault operator unseal

vault login <ROOT_TOKEN>

vault auth enable kubernetes

kubectl create serviceaccount backend-sa -n foodexpress

kubectl create token backend-sa -n foodexpress

vault write auth/kubernetes/config \
token_reviewer_jwt=<JWT_TOKEN> \
kubernetes_host=<K8S_HOST> \
kubernetes_ca_cert=<CA_CERT>

vault kv put secret/foodexpress \
DB_USER=root \
DB_PASSWORD=password123 \
DB_NAME=foodexpress

vault policy write foodexpress vault-policy.hcl

vault write auth/kubernetes/role/foodexpress \
bound_service_account_names=backend-sa \
bound_service_account_namespaces=foodexpress \
policies=foodexpress \
ttl=24h

kubectl apply -f backend-deployment.yaml

kubectl rollout restart deployment/backend -n foodexpress

kubectl get pods -n foodexpress

kubectl logs <backend-pod-name> -n foodexpress -c vault-agent

cat /vault/secrets/config