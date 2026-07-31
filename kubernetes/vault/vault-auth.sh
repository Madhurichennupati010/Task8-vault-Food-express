#!/bin/bash

vault auth enable kubernetes

vault write auth/kubernetes/config \
  token_reviewer_jwt="$TOKEN" \
  kubernetes_host="https://172.30.1.2:6443" \
  kubernetes_ca_cert=@ca.crt