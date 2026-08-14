Feature: Testes de validação e cenários negativos

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }
    * def gerarEmail = function(){ return 'usuario' + java.lang.System.currentTimeMillis() + '@teste.com' }

  Scenario: Criar usuário com nome contendo quantidade elevada de caracteres
    Given path 'usuarios'
    * def email = gerarEmail()
    * def nomeGrande = 'A'.repeat(300)
    And request
      """
      {
        "nome": "#(nomeGrande)",
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

  Scenario: Criar usuário com email contendo quantidade elevada de caracteres
    Given path 'usuarios'
    * def emailGrande = 'a'.repeat(250) + '@teste.com'
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "#(emailGrande)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.email == '#string'

  Scenario: Criar usuário com campo password muito curto
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

  Scenario: Criar usuário com campo administrador inválido
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Admin Inválido",
        "email": "#(email)",
        "password": "senha123",
        "administrador": "sim"
      }
      """
    When method post
    Then status 400

  Scenario: Requisição sem Content-Type header
    Given configure headers = {}
    And path 'usuarios'
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

  Scenario: Requisição com método HTTP inválido
    Given path 'usuarios'
    When method patch
    Then status 405

  Scenario: Acessar endpoint inexistente
    Given path 'endpoint-inexistente'
    When method get
    Then status 405
    And match response.message == '#string'

  Scenario: Criar usuário com campos adicionais não esperados
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true",
        "campoExtra": "valor extra"
      }
      """
    When method post
    Then status 400
    And match response.campoExtra == '#string'
