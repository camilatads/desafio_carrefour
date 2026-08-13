Feature: Buscar usuário por ID - GET /users/{id}

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }
    * def gerarEmail = function(){ return 'usuario' + java.lang.System.currentTimeMillis() + '@teste.com' }

  Scenario: Buscar usuário por ID válido
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Para Busca",
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    * print 'Usuário criado com ID:', userId
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response._id == userId
    And match response.nome == 'Usuário Para Busca'
    And match response.email == email
    And match response.password == '#string'
    And match response.administrador == 'true'

  Scenario: Buscar usuário por ID inexistente
    Given path 'usuarios', '999999999999999999999999'
    When method get
    Then status 400
    And match response.message == '#string'

  Scenario: Buscar usuário com ID em formato inválido
    Given path 'usuarios', 'id-invalido'
    When method get
    Then status 400
    And match response.message == '#string'

  Scenario: Buscar usuário com ID vazio
    Given path 'usuarios', ''
    When method get
    Then status 400
    And match response.message == '#string'
