#!/bin/bash

vault auth enable kubernetes

vault write auth/kubernetes/config \
token_reviewer_jwt="<TOKEN_REVIEWER_JWT>" \
kubernetes_host="<KUBERNETES_API_SERVER>" \
kubernetes_ca_cert=@ca.crt