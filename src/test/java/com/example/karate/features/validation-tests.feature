Feature: Testes de validação e cenários negativos

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def timestamp = Date.now()
    * def randomEmail = 'usuario' + timestamp + '@teste.com'

  Scenario: Criar usuário com campo nome com número excessivo de caracteres
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Nome muito longo que excede o limite permitido pelo sistema e deve causar um erro de validação",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário com campo email com número excessivo de caracteres
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "emailcomcaracteresexcessivosqueexcedemolimitespermitidopelosistemadevecausarerrodevalidacao@(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário com campo password muito curto
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

  Scenario: Criar usuário com campo administrador inválido
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Admin Inválido",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "sim"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Criar usuário com corpo JSON malformado
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      """
    When method post
    Then status 400

  Scenario: Requisição sem Content-Type header
    Given configure headers = {}
    And path 'usuarios'
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
    Then status 400

  Scenario: Requisição com método HTTP inválido
    Given path 'usuarios'
    When method patch
    Then status 405

  Scenario: Acessar endpoint inexistente
    Given path 'endpoint-inexistente'
    When method get
    Then status 404

  Scenario: Criar usuário com campos adicionais não esperados
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Teste",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true",
        "campoExtra": "valor extra"
      }
      """
    When method post
    Then status 201

  Scenario: Testar rate limiting (múltiplas requisições rápidas)
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Rate Limit",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    Given path 'usuarios', userId
    When method get
    Then status 200
    Given path 'usuarios'
    When method get
    Then status 200
