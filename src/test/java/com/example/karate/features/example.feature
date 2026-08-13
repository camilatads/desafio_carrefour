Feature: Example Test Suite

  Scenario: First test example
    Given url 'https://jsonplaceholder.typicode.com/posts/1'
    When method get
    Then status 200
    And match response contains { id: 1 }
