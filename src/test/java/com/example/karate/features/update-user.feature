Feature: Atualizar usuário - PUT /users/{id}

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def timestamp = Date.now()
    * def randomEmail = 'usuario' + timestamp + '@teste.com'

  Scenario: Atualizar usuário com sucesso
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Original",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    * print 'Usuário criado com ID:', userId
    Given path 'usuarios', userId
    And request
      """
      {
        "nome": "Usuário Atualizado",
        "email": "#(randomEmail)",
        "password": "novaSenha456",
        "administrador": "false"
      }
      """
    When method put
    Then status 200
    And match response.message == 'Registro alterado com sucesso'
    And match response._id == userId
    * print 'Usuário atualizado com sucesso'

  Scenario: Atualizar apenas o nome do usuário
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Para Atualizar Nome",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    Given path 'usuarios', userId
    And request
      """
      {
        "nome": "Nome Atualizado",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

  Scenario: Atualizar usuário com ID inexistente
    Given path 'usuarios', '999999999999999999999999'
    And request
      """
      {
        "nome": "Usuário Inexistente",
        "email": "inexistente@teste.com",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 400
    And match response.message == '#string'

  Scenario: Atualizar usuário sem campo nome
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Sem Nome",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    Given path 'usuarios', userId
    And request
      """
      {
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 400
    And match response.message == '#string'

  Scenario: Atualizar usuário sem campo email
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Sem Email",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    Given path 'usuarios', userId
    And request
      """
      {
        "nome": "Usuário Sem Email",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 400
    And match response.message == '#string'

  Scenario: Atualizar usuário com email já existente
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário 1",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId1 = response._id
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário 2",
        "email": "usuario2@(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId2 = response._id
    Given path 'usuarios', userId2
    And request
      """
      {
        "nome": "Usuário 2",
        "email": randomEmail,
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 400
    And match response.message == 'Este email já está sendo usado'
