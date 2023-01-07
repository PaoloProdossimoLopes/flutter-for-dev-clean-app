# Remote Authentication Use cases

> ## Caso de sucesso:
1. Sistema valida os dados 
2. Sistema faz requisição para a URL da API de login
3. Sistema valida os dados recebidos da API
4. Sistema entrega os dados da conta do usuario

> ## Execução - URL invalida (status code: 404)
1. Sistama retorna uma mensagem de erro inesperado

> ## Exceção - Dados invalidos (status code: 400)
1. Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Resposata invalida (status code: 200/204 (error na decodificaçao/resposta vazia)))
1. Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Falha no servidor (status code: 500)
1. Sistama retorna uma mensagem de erro inesperado

> ## Exceção - Credenciais invalidas (status code: 401)
1. Sistema retorna uma mensagem de erro informado que as credenciais estao erradas