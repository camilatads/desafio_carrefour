Feature: Listar usuários - GET /users

  Background:
    * url 'https://serverest.dev'
    * configure headers = { 'Content-Type': 'application/json' }

  Scenario: Listar todos os usuários com sucesso
    Given path 'usuarios'
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'
    And match each response.usuarios contains { nome: '#string', email: '#string', password: '#string', administrador: '#string', _id: '#string' }

  Scenario: Listar usuários com paginação
    Given path 'usuarios'
    And param _limit = 5
    And param _page = 1
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'
    And assert response.usuarios.length <= 5

  Scenario: Listar usuários com filtro por nome
    Given path 'usuarios'
    And param nome = 'Fulano'
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'

  Scenario: Listar usuários com filtro por email
    Given path 'usuarios'
    And param email = 'fulano@qa.com'
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'

  Scenario: Listar usuários com múltiplos filtros
    Given path 'usuarios'
    And param nome = 'Fulano'
    And param _limit = 10
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'

  Scenario: Listar usuários com limite zero
    Given path 'usuarios'
    And param _limit = 0
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'
