# ServeRest API - Test Automation

Projeto de automação de testes para a API REST ServeRest, desenvolvido utilizando
Karate Framework, JUnit 5, Maven e GitHub Actions.

O projeto tem como objetivo validar as operações de autenticação e gerenciamento
de usuários da API, contemplando cenários positivos, negativos, validações de
dados e integração entre diferentes operações.

---

## 📋 Sobre o projeto

A API ServeRest disponibiliza endpoints para autenticação e gerenciamento de
usuários.

A automação contempla os principais fluxos de:

- Autenticação
- Criação de usuários
- Consulta de usuários
- Consulta de usuário por ID
- Atualização de usuários
- Exclusão de usuários
- Validação de dados obrigatórios
- Validação de dados inválidos
- Validação de e-mails duplicados
- Validação de IDs inexistentes ou inválidos
- Validação de métodos HTTP
- Validação de endpoints inexistentes
- Validação de estrutura das respostas

Os testes foram implementados utilizando arquivos `.feature` do Karate,
seguindo uma abordagem orientada a cenários.

---

# 🛠️ Tecnologias utilizadas

- Java 11+
- Maven 3.6+
- Karate Framework
- JUnit 5
- Git
- GitHub Actions
- ServeRest API

---

# 📁 Estrutura do projeto

```text
untitled1/
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