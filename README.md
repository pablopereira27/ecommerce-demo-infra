# Infraestrutura do E-commerce Demo (Docker Compose)

## 📖 Proposta

Este repositório faz parte de um projeto **demo de microserviços** para um e-commerce simples.  
A arquitetura é composta por 3 serviços independentes e 1 repositório com a infraestrutura compartilhada.

O objetivo é ser **simples e leve**, mostrando boas práticas de microserviços.

### Auth Service

**Repositório:** [ecommerce-demo-auth-service](https://github.com/pablopereira27/ecommerce-demo-auth-service)  
Responsável pela autenticação e gestão de usuários.

### Product Service

**Repositório:** [ecommerce-demo-product-service](https://github.com/pablopereira27/ecommerce-demo-product-service)  
Responsável pelo catálogo de produtos.

### Order Service

**Repositório:** [ecommerce-demo-order-service](https://github.com/pablopereira27/ecommerce-demo-order-service)  
Responsável pelo processamento e gestão de pedidos.

### Infra

**Repositório:** <u>Este repositório</u><br/>
Responsável por **“hostiar” containers de serviços de infraestrutura** como RabbitMQ, monitoramento e relatórios.

---

## 📌 Estrutura

- Cada microserviço (ex: `product-service`, `stock-service`, `order-service`) possui seu próprio `docker-compose.yml` e `.env`.
- O projeto de infra possui um `docker-compose.yml` separado, responsável apenas pelos serviços compartilhados.
- Os scripts foram criados para facilitar a execução conjunta de todos os `docker-compose.yml` sem precisar digitar comandos longos:
  - **run-all.ps1** → para usuários Windows (PowerShell/CMD).
  - **run-all.sh** → para usuários Linux/Mac/WSL/Git Bash.

---

## 📌 O que o `run-all` faz:

1. Lê variáveis específicas dos arquivos `.env` de cada microserviço (como `APP_PORT` e `INFRA_PORT`).
2. Exporta essas variáveis para o ambiente, garantindo que o Docker Compose consiga interpolá-las.
3. Executa o comando `docker compose` mesclando os arquivos de cada microserviço **junto com o compose da infra**, criando uma rede única.
4. Sobe todos os containers necessários de uma vez, já com as dependências corretas (`depends_on` funciona porque os arquivos são mesclados).

---

## 🚀 Como rodar o `run-all` no Windows

Este guia explica como executar os scripts **bash** `run-all.sh` e **powershell** `run-all.ps1`, ambos no Windows.

### 📌 Pré-requisitos

- **Docker Desktop** instalado e funcionando.
- Caso opte por rodar o script bash no windows, um dos seguintes ambientes deve estar disponível:
  - [Git Bash](https://git-scm.com/download/win) (vem junto com Git for Windows).
  - [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/windows/wsl/install) com uma distribuição Linux (ex: Ubuntu).

<details>
    <summary>📌 Passo a passo para rodar o script Bash com Git Bash</summary>
 
1. **Instale o Git for Windows** (se ainda não tiver).
2. Abra o **Git Bash** na pasta `ecommerce-demo-infra`.
3. Dê permissão de execução ao script:
   ```bash
        chmod +x run-all.sh
   ```
4. Execute o script:
   ```bash
        ./run-all.sh
   ``` 
</details>

<details>
    <summary>📌 Passo a passo para rodar o script Bash com WSL</summary>

1. Instale o WSL e configure uma distribuição Linux (ex: Ubuntu).
2. Copie o script `run-all.sh` para dentro da pasta do projeto acessível pelo WSL.
3. Abra o terminal WSL e vá até a pasta `ecommerce-demo-infra`.
4. Dê permissão de execução ao script:
   ```bash
        chmod +x run-all.sh
   ```
5. Execute o script:
   ```bash
        ./run-all.sh
   ```

</details>

<details>
    <summary>📌 Passo a passo para rodar o script em PowerShell no Powershell</summary>

1. Abra o **PowerShell** na pasta `ecommerce-demo-infra`.
2. Execute:
   ```powershell
        ./run-all.ps1
   ```

</details>

<details>
    <summary>📌 Passo a passo para rodar o script em PowerShell no CMD</summary>

1. Abra o **CMD** na pasta `ecommerce-demo-infra`.
2. Execute:

   ```powershell
       powershell -ExecutionPolicy Bypass -File run-all.ps1
   ```

   </details>

---

## 📌 Observações

- O `.env` da **infra** continua sendo usado normalmente para variáveis próprias (como portas externas).
- Os `.env` dos **microserviços** continuam sendo a fonte da verdade para suas variáveis internas.
- Se houver conflito de nomes de variáveis, o valor exportado pelo script tem prioridade sobre o `.env` da infra.

---

## 🛑 Parar e limpar containers

Para desligar todos os serviços, basta rodar:

```
    docker compose down
```

Para remover volumes e redes criadas:

```
    docker compose down -v
```

---

## 📌 Estrutura de Pastas

```
ecommerce-demo/
├── ecommerce-demo-infra/
│   ├── docker-compose.yml
│   ├── run-all.ps1
│   ├── run-all.sh
│   └── .env
├── ecommerce-demo-product-service/
│   ├── docker-compose.yml
│   ├── .env
│   └── src/...
├── ecommerce-demo-stock-service/
│   ├── docker-compose.yml
│   ├── .env
│   └── src/...
└── ecommerce-demo-order-service/
    ├── docker-compose.yml
    ├── .env
    └── src/...
```
