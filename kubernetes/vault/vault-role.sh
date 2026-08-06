#!/bin/sh

vault write auth/kubernetes/role/foodexpress \
  bound_service_account_names=backend-sa \
  bound_service_account_namespaces=foodexpress \
  policies=foodexpress \
  ttl=24h