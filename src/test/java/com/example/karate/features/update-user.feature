Feature: Atualizar usuário - PUT /users/{id}

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }
    * def gerarEmail = function(){ return 'usuario' + java.lang.System.currentTimeMillis() + '@teste.com' }

  Scenario: Atualizar usuário com sucesso
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
    * def userId = response._id
    * print 'Usuário criado com ID:', userId
    Given path 'usuarios', userId
    And request
      """
      {
        "nome": "Usuário Atualizado",
        "email": "#(email)",
        "password": "novaSenha456",
        "administrador": "false"
      }
      """
    When method put
    Then status 200
    And match response.message == 'Registro alterado com sucesso'
    And match response._id == userId
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response.nome == 'Usuário Atualizado'
    And match response.email == email
    And match response.administrador == 'false'
    * print 'Usuário atualizado com sucesso'

  Scenario: Atualizar usuário alterando o valor do nome
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Para Atualizar Nome",
        "email": "#(email)",
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
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 200
    And match response.message == 'Registro alterado com sucesso'
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response.nome == 'Nome Atualizado'

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
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Sem Nome",
        "email": "#(email)",
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
        "email": "#(email)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 400
    And match response.message == '#string'

  Scenario: Atualizar usuário sem campo email
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Sem Email",
        "email": "#(email)",
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
    * def email1 = gerarEmail()
    And request
      """
      {
        "nome": "Usuário 1",
        "email": "#(email1)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    Given path 'usuarios'
    * def email2 = gerarEmail()
    And request
      """
      {
        "nome": "Usuário 2",
        "email": "#(email2)",
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
        "email": "#(email1)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method put
    Then status 400
    And match response.message == 'Este email já está sendo usado'
