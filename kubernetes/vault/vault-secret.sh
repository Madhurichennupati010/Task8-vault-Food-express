#!/bin/sh

vault kv put secret/foodexpress \
DB_HOST=mysql-service \
DB_NAME=foodexpress \
DB_USER=root \
DB_PASSWORD=password123 \
API_KEY=FoodExpressAPI123