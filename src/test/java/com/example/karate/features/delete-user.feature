Feature: Excluir usuário - DELETE /users/{id}

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def timestamp = Date.now()
    * def randomEmail = 'usuario' + timestamp + '@teste.com'

  Scenario: Excluir usuário com sucesso
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Para Excluir",
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
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'
    And match response._id == userId
    * print 'Usuário excluído com sucesso'

  Scenario: Excluir usuário com ID inexistente
    Given path 'usuarios', '999999999999999999999999'
    When method delete
    Then status 400
    And match response.message == '#string'

  Scenario: Excluir usuário com ID inválido (formato incorreto)
    Given path 'usuarios', 'id-invalido'
    When method delete
    Then status 400
    And match response.message == '#string'

  Scenario: Excluir usuário com ID vazio
    Given path 'usuarios', ''
    When method delete
    Then status 400
    And match response.message == '#string'

  Scenario: Excluir usuário e verificar que não existe mais
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Para Verificar Exclusão",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    Given path 'usuarios', userId
    When method delete
    Then status 200
    Given path 'usuarios', userId
    When method get
    Then status 400
    And match response.message == '#string'

  Scenario: Tentar excluir o mesmo usuário duas vezes
    Given path 'usuarios'
    And request
      """
      {
        "nome": "Usuário Dupla Exclusão",
        "email": "#(randomEmail)",
        "password": "senha123",
        "administrador": "true"
      }
      """
    When method post
    Then status 201
    * def userId = response._id
    Given path 'usuarios', userId
    When method delete
    Then status 200
    Given path 'usuarios', userId
    When method delete
    Then status 400
    And match response.message == '#string'
