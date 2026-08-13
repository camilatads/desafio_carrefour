Feature: Criar usuário - POST /usuarios

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }
    * def gerarEmail = function(){ return 'usuario' + java.lang.System.currentTimeMillis() + '@teste.com' }

  Scenario: Criar usuário com sucesso com todos os campos obrigatórios
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "#(email)",
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
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Não Admin",
        "email": "#(email)",
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
    * def email = gerarEmail()
    And request
      """
      {
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400

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

  Scenario: Criar usuário sem campo password
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Sem Senha",
        "email": "#(email)",
        "administrador": "true"
      }
      """
    When method post
    Then status 400

  Scenario: Criar usuário sem campo administrador
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Sem Admin",
        "email": "#(email)",
        "password": "senha123"
      }
      """
    When method post
    Then status 400

  Scenario: Criar usuário com email já existente
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Original",
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Duplicado",
        "email": "#(email)",
        "password": "senha456",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Este email já está sendo usado'

  Scenario: Criar usuário com nome vazio
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "",
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400

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

  Scenario: Criar usuário com password curta
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Senha Curta",
        "email": "#(email)",
        "password": "123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'
