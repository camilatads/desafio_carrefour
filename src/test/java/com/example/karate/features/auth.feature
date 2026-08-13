Feature: Autenticação na API ServeRest

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }

  Scenario: Login com credenciais válidas e obtenção do token JWT
    Given path 'login'
    And request
      """
      {
        "email": "fulano@qa.com",
        "password": "teste"
      }
      """
    When method post
    Then status 200
    And match response == { authorization: '#string', message: 'Login realizado com sucesso' }
    * def authToken = response.authorization
    * print 'Token obtido:', authToken

  Scenario: Login com email inválido
    Given path 'login'
    And request
      """
      {
        "email": "invalido@email.com",
        "password": "teste"
      }
      """
    When method post
    Then status 401
    And match response.message == 'Email e/ou senha inválidos'

  Scenario: Login com senha inválida
    Given path 'login'
    And request
      """
      {
        "email": "fulano@qa.com",
        "password": "senhaerrada"
      }
      """
    When method post
    Then status 401
    And match response.message == 'Email e/ou senha inválidos'

  Scenario: Login sem campo email
    Given path 'login'
    And request
      """
      {
        "password": "teste"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'

  Scenario: Login sem campo password
    Given path 'login'
    And request
      """
      {
        "email": "fulano@qa.com"
      }
      """
    When method post
    Then status 400
    And match response.message == '#string'
