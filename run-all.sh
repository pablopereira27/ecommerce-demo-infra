#!/bin/bash

# Caminhos dos .env
productEnv="../ecommerce-demo-product-service/.env"
# stockEnv="../ecommerce-demo-stock-service/.env"
# orderEnv="../ecommerce-demo-order-service/.env"

# Função para pegar uma variável específica de um .env
get_env_var() {
  local file=$1
  local varName=$2
  grep "^$varName=" "$file" | cut -d '=' -f2
}

# Carrega variáveis específicas
export PRODUCT_APP_PORT=$(get_env_var "$productEnv" "APP_PORT")
export PRODUCT_INFRA_PORT=$(get_env_var "$productEnv" "INFRA_PORT")

# export STOCK_APP_PORT=$(get_env_var "$stockEnv" "APP_PORT")
# export STOCK_INFRA_PORT=$(get_env_var "$stockEnv" "INFRA_PORT")

# export ORDER_APP_PORT=$(get_env_var "$orderEnv" "APP_PORT")
# export ORDER_INFRA_PORT=$(get_env_var "$orderEnv" "INFRA_PORT")

# Agora roda o docker compose com merge
docker compose \
    -f ../ecommerce-demo-product-service/docker-compose.yml \
    -f ./docker-compose.yml up -d