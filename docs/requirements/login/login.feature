Funcionalidade: Login
como cliente
Desejo acessar minha conta e me manter logado
Para que eu possa ver e responder enquetes de forma rápida

Cenário: Credenciais Válidas
Dado que o cliente informou credenciais válidas 
Quando solicitar para fazer login 
Então o sistema deve enviar o usuario para a tela de pesquisa
E manter o usuario conectado

Cenário: Credenciais Invalidas
Dado que o cliente informou credenciais inválidas 
Quando solicitar para fazer login 
Então o sistema deve enviar uma mensagem de erro