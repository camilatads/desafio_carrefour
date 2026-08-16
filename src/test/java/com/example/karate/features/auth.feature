Feature: Autenticação na API ServeRest

Background:
* url 'https://serverest.dev'
* configure headers = { 'Content-Type': 'application/json' }

Scenario: Login com credenciais válidas e obtenção do token JWT


* def email = 'login' + java.lang.System.currentTimeMillis() + '@teste.com'
* def password = 'senha123'

Given path 'usuarios'
And request
"""
{
  "nome": "Usuário Login",
  "email": "#(email)",
  "password": "#(password)",
  "administrador": "true"
}
"""
When method post
Then status 201

Given path 'login'
And request
"""
{
  "email": "#(email)",
  "password": "#(password)"
}
"""
When method post
Then status 200
And match response.message == 'Login realizado com sucesso'
And match response.authorization == '#string'

* def authToken = response.authorization
* print 'Token obtido:', authToken


Scenario: Login com email inválido


* def emailInvalido = 'emailinexistente' + java.lang.System.currentTimeMillis() + '@teste.com'

Given path 'login'
And request
"""
{
  "email": "#(emailInvalido)",
  "password": "senha123"
}
"""
When method post
Then status 401
And match response.message == 'Email e/ou senha inválidos'


Scenario: Login com senha inválida


* def emailInvalido = 'emailinexistente' + java.lang.System.currentTimeMillis() + '@teste.com'

Given path 'login'
And request
"""
{
  "email": "#(emailInvalido)",
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
And match response.email == '#string'


Scenario: Login sem campo password


* def emailInvalido = 'emailinexistente' + java.lang.System.currentTimeMillis() + '@teste.com'

Given path 'login'
And request
"""
{
  "email": "#(emailInvalido)"
}
"""
When method post
Then status 400
And match response.password == '#string'
