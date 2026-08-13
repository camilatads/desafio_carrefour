# ServeRest API Test Automation

Projeto de testes automatizados para a API ServeRest utilizando **Karate Framework** com cobertura completa dos endpoints de usuários.

## 📋 Descrição

Este projeto implementa testes automatizados para a API ServeRest (https://serverest.dev/), cobrindo todas as operações CRUD de usuários com autenticação JWT e validação de cenários positivos e negativos.

## 🎯 Cobertura de Testes

### Endpoints Testados
- **POST /login** - Autenticação e obtenção de token JWT
- **GET /usuarios** - Listar todos os usuários (com filtros e paginação)
- **POST /usuarios** - Criar novo usuário
- **GET /usuarios/{id}** - Buscar usuário específico por ID
- **PUT /usuarios/{id}** - Atualizar informações do usuário
- **DELETE /usuarios/{id}** - Excluir usuário

### Cenários de Teste
- ✅ Cenários positivos (fluxo feliz)
- ❌ Cenários negativos (validação de erros)
- 🔒 Validação de campos obrigatórios
- 📧 Validação de email duplicado
- 🚫 Validação de IDs inexistentes
- 📏 Validação de limites de campos
- 🔀 Testes de rate limiting

## 🛠️ Pré-requisitos

- **Java 11+**
- **Maven 3.6+**
- **Git**

## 📦 Instalação

1. Clone o repositório:
```bash
git clone <URL_DO_REPOSITORIO>
cd untitled1
```

2. Compile o projeto:
```bash
mvn clean install
```

## 🚀 Executar Testes

### Executar todos os testes:
```bash
mvn test
```

### Executar testes específicos:
```bash
mvn test -Dtest=ExampleTest
```

### Executar via IntelliJ IDEA:
- Abra a classe `ExampleTest.java` em `src/test/java/com/example/karate/`
- Clique com o botão direito e selecione "Run 'ExampleTest'"

## 📁 Estrutura do Projeto

```
untitled1/
├── src/
│   └── test/
│       └── java/
│           └── com/example/karate/
│               ├── ExampleTest.java           # Runner JUnit 5
│               ├── karate-config.js           # Configuração global
│               └── features/
│                   ├── auth.feature           # Testes de autenticação
│                   ├── get-users.feature      # Testes GET /usuarios
│                   ├── create-user.feature    # Testes POST /usuarios
│                   ├── get-user-by-id.feature # Testes GET /usuarios/{id}
│                   ├── update-user.feature    # Testes PUT /usuarios/{id}
│                   ├── delete-user.feature    # Testes DELETE /usuarios/{id}
│                   └── validation-tests.feature # Testes de validação
├── .github/
│   └── workflows/
│       └── karate-tests.yml       # Pipeline CI/CD GitHub Actions
├── pom.xml                        # Configuração Maven
└── README.md                      # Documentação
```

## 📊 Relatórios

Após a execução dos testes, os relatórios são gerados em:
- **target/karate-reports/** - Relatórios HTML do Karate
- **target/surefire-reports/** - Relatórios XML JUnit

## 🔄 CI/CD

O projeto está configurado com **GitHub Actions** para execução automática dos testes:

### Gatilhos:
- Push para branches `main` e `develop`
- Pull requests para branches `main` e `develop`
- Execução manual via workflow_dispatch

### Artefatos:
- Relatórios Karate HTML (retidos por 30 dias)
- Relatórios JUnit XML (retidos por 30 dias)
- Resultados dos testes publicados no GitHub

## 🔧 Configuração

### URL da API
A URL base está configurada em `karate-config.js`:
```javascript
var config = {
  baseUrl: 'https://serverest.dev',
  authUrl: 'https://serverest.dev/login'
};
```

### Rate Limiting
O projeto respeita o limite de 100 requisições por minuto da API com delays configurados.

## 📝 Campos Obrigatórios para Usuário

```json
{
  "nome": "string",
  "email": "string",
  "password": "string",
  "administrador": "string"
}
```

## 🧪 Exemplo de Teste

```gherkin
Feature: Criar usuário - POST /users

  Scenario: Criar usuário com sucesso
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "teste@email.com",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
```

## 📚 Recursos

- [Karate Documentation](https://karate.io/)
- [ServeRest API Documentation](https://serverest.dev/#/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 👥 Contribuindo

1. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
2. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
3. Push para a branch (`git push origin feature/nova-feature`)
4. Abra um Pull Request

## 📄 Licença

Este projeto é utilizado para fins de demonstração e teste.
