# Caminhos dos .env
$productEnv = "..\ecommerce-demo-product-service\.env"
# $stockEnv   = "..\ecommerce-demo-stock-service\.env"
# $orderEnv   = "..\ecommerce-demo-order-service\.env"

# Função para pegar uma variável específica de um .env
function Get-EnvVar($file, $varName) {
    $line = Get-Content $file | Where-Object { $_ -match "^$varName=" }
    if ($line) {
        return ($line -split "=",2)[1]
    }
    return $null
}

# Carrega variáveis específicas
$env:PRODUCT_APP_PORT        = Get-EnvVar $productEnv "APP_PORT"
$env:PRODUCT_INFRA_PORT      = Get-EnvVar $productEnv "INFRA_PORT"

# $env:STOCK_APP_PORT      = Get-EnvVar $stockEnv "APP_PORT"
# $env:STOCK_INFRA_PORT    = Get-EnvVar $stockEnv "INFRA_PORT"

# $env:ORDER_APP_PORT      = Get-EnvVar $orderEnv "APP_PORT"
# $env:ORDER_INFRA_PORT    = Get-EnvVar $orderEnv "INFRA_PORT"

# Agora roda o docker compose com merge
# docker compose `
#     -f ..\ecommerce-demo-product-service\docker-compose.yml `
#     -f ..\ecommerce-demo-stock-service\docker-compose.yml `
#     -f ..\ecommerce-demo-order-service\docker-compose.yml `
#     -f .\docker-compose.yml up -d

docker compose `
    -f ..\ecommerce-demo-product-service\docker-compose.yml `
    -f .\docker-compose.yml up -d
