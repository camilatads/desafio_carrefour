# ServeRest API - Test Automation

Projeto de automação de testes para a API REST ServeRest, desenvolvido com **Karate Framework, JUnit 5, Maven e GitHub Actions**.

O objetivo do projeto é validar as operações de autenticação e gerenciamento de usuários, contemplando cenários positivos, negativos, validações de dados, estrutura das respostas e integração entre diferentes operações da API.

---

## 📋 Sobre o projeto

A API ServeRest disponibiliza endpoints para autenticação e gerenciamento de usuários.

A automação contempla os principais fluxos de:

- Autenticação
- Criação de usuários
- Consulta de usuários
- Consulta de usuário por ID
- Atualização de usuários
- Exclusão de usuários
- Validação de campos obrigatórios
- Validação de dados inválidos
- Validação de e-mails duplicados
- Validação de IDs inexistentes ou inválidos
- Validação de métodos HTTP não suportados
- Validação de endpoints inexistentes
- Validação estrutural das respostas

Os testes foram implementados em arquivos `.feature` utilizando o **Karate Framework**, seguindo uma abordagem orientada a cenários.

---

## 🛠️ Tecnologias utilizadas

- Java 11+
- Maven 3.6+
- Karate Framework
- JUnit 5
- Git
- GitHub
- GitHub Actions
- ServeRest API

---

## 📁 Estrutura do projeto

```text
desafio_carrefour/
│
├── .github/
│   └── workflows/
│       └── karate-tests.yml
│
├── src/
│   └── test/
│       └── java/
│           └── com/
│               └── example/
│                   └── karate/
│                       ├── ExampleTest.java
│                       ├── karate-config.js
│                       │
│                       └── features/
│                           ├── auth.feature
│                           ├── get-users.feature
│                           ├── create-user.feature
│                           ├── get-user-by-id.feature
│                           ├── update-user.feature
│                           ├── delete-user.feature
│                           └── validation-tests.feature
│
├── pom.xml
└── README.md
```

---

## 🎯 Cobertura da automação

A suíte automatizada cobre os seguintes recursos da API:

| Endpoint | Método | Cenários positivos | Cenários negativos |
|---|---|:---:|:---:|
| `/login` | POST | ✅ | ✅ |
| `/usuarios` | GET | ✅ | ✅ |
| `/usuarios` | POST | ✅ | ✅ |
| `/usuarios/{id}` | GET | ✅ | ✅ |
| `/usuarios/{id}` | PUT | ✅ | ✅ |
| `/usuarios/{id}` | DELETE | ✅ | ✅ |

Além das operações principais, são realizadas validações de status HTTP, mensagens de resposta, campos obrigatórios, tipos de dados e estrutura das respostas da API.

---

## ▶️ Como executar

### Pré-requisitos

Para executar o projeto localmente é necessário possuir:

- Java 11 ou superior
- Maven 3.6 ou superior
- Git

### Clonar o repositório

```bash
git clone https://github.com/camilatads/desafio_carrefour.git
cd desafio_carrefour
```

### Executar a suíte de testes

```bash
mvn test
```

Após a execução, o Maven iniciará o runner JUnit responsável pela execução das features do Karate.

---

## 📊 Resultado da execução

Na execução final da suíte automatizada foram obtidos os seguintes resultados:

| Métrica | Resultado |
|---|---:|
| Features executadas | 7 |
| Cenários executados | 45 |
| Cenários aprovados | 45 |
| Cenários com falha | 0 |
| Taxa de aprovação | **100%** |

### Resultado por feature

| Feature | Cenários | Aprovados | Falhas |
|---|---:|---:|---:|
| Autenticação | 5 | 5 | 0 |
| Criação de usuários | 10 | 10 | 0 |
| Exclusão de usuários | 6 | 6 | 0 |
| Consulta de usuário por ID | 4 | 4 | 0 |
| Listagem de usuários | 6 | 6 | 0 |
| Atualização de usuários | 6 | 6 | 0 |
| Validações e cenários negativos | 8 | 8 | 0 |
| **Total** | **45** | **45** | **0** |

---

## 🔄 CI/CD

O projeto possui integração contínua configurada utilizando **GitHub Actions**.

O workflow está localizado em:

```text
.github/workflows/karate-tests.yml
```

A pipeline realiza automaticamente:

- Configuração do ambiente Java
- Instalação das dependências do projeto
- Execução dos testes através do Maven
- Execução da suíte Karate
- Geração dos relatórios de teste
- Disponibilização dos relatórios como artefatos da execução

O fluxo de execução é:

```text
Push / Pull Request
        ↓
GitHub Actions
        ↓
Setup Java
        ↓
Maven
        ↓
Karate
        ↓
Execução dos testes
        ↓
Geração dos relatórios
        ↓
Upload dos artefatos
```

O JUnit é responsável por iniciar o runner da suíte, enquanto o relatório do Karate apresenta individualmente as features e os cenários funcionais executados.

---

## 📑 Relatórios

Após a execução dos testes, o Karate gera automaticamente os relatórios em:

```text
target/karate-reports/
```

Os relatórios permitem consultar:

- Features executadas
- Cenários executados
- Cenários aprovados
- Cenários com falha
- Tempo de execução
- Detalhes das requisições
- Respostas da API
- Validações realizadas

Na execução através do GitHub Actions, os relatórios são disponibilizados como **artefatos da pipeline**, permitindo a consulta das evidências após a conclusão da execução.

---

## 📄 Documentação

Além do README, o projeto possui um **Plano de Testes e Estratégia de Automação**, contendo o detalhamento da estratégia de qualidade adotada no projeto.

A documentação contempla:

- Objetivo e escopo
- Estratégia de testes
- Matriz de cobertura
- Cenários automatizados
- Estratégia de dados de teste
- Isolamento dos testes
- Validação estrutural e de tipos das respostas
- Critérios de entrada e saída
- Estrutura de execução
- CI/CD
- Resultados e evidências
- Gestão de falhas
- Riscos e limitações
- Melhorias futuras

---

## 👩‍💻 Autora

**Camila Virgilino Samuel**