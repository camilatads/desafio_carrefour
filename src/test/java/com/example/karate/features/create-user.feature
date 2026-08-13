Feature: Criar usuário - POST /users

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def timestamp = Date.now()
    * def randomEmail = 'usuario' + timestamp + '@teste.com'

  Scenario: Criar usuário com sucesso com todos os campos obrigatórios
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'
    * def userId = response._id
    * print 'Usuário criado com ID:', userId

  Scenario: Criar usuário com administrador false
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Não Admin",
        "email": "naoadmin@(randomEmail)",
        "password": "senha123",
        "administrador": "false"
      }
      """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

  Scenario: Criar usuário sem campo nome
    Given path 'usuarios'
    And request
      """
      {
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário sem campo email
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Sem Email",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário sem campo password
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Sem Senha",
        "email": "#(randomEmail)",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário sem campo administrador
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Sem Admin",
        "email": "#(randomEmail)",
        "password": "senha123"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário com email já existente
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Fulano da Silva",
        "email": "fulano@qa.com",
        "password": "teste",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Este email já está sendo usado'

  Scenario: Criar usuário com nome vazio
    Given path 'usuarios'
    And request
      """
      {
        "nome": "",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário com email inválido
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Email Inválido",
        "email": "emailinvalido",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário com password muito curto
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Senha Curta",
        "email": "#(randomEmail)",
        "password": "123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'
