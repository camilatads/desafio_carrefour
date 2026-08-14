Feature: Excluir usuário - DELETE /users/{id}

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }
    * def gerarEmail = function(){ return 'usuario' + java.lang.System.currentTimeMillis() + '@teste.com' }

  Scenario: Excluir usuário com sucesso
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Para Excluir",
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
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'
    * print 'Usuário excluído com sucesso'

  Scenario: Excluir usuário com ID inexistente
    Given path 'usuarios', '999999999999999999999999'
    When method delete
    Then status 200
    And match response.message == 'Nenhum registro excluído'

  Scenario: Excluir usuário com ID inválido (formato incorreto)
    Given path 'usuarios', 'id-invalido'
    When method delete
    Then status 200
    And match response.message == 'Nenhum registro excluído'

  Scenario: Excluir usuário com ID vazio
    Given path 'usuarios', ''
    When method delete
    Then status 405
    And match response.message == '#string'

  Scenario: Excluir usuário e verificar que não existe mais
    Given path 'usuarios'
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Para Verificar Exclusão",
        "email": "#(email)",
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
    * def email = gerarEmail()
    And request
      """
      {
        "nome": "Usuário Dupla Exclusão",
        "email": "#(email)",
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
    Then status 200
    And match response.message == 'Nenhum registro excluído'
