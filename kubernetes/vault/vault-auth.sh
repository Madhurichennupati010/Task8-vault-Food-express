#!/bin/sh

vault auth enable kubernetes

vault write auth/kubernetes/config \
  token_reviewer_jwt="$TOKEN" \
  kubernetes_host="https://192.168.49.2:8443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt