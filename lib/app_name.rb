class AppName 
  def initialize(app)
    @app = app # essa instância app nada mais é que o próprio aplicativo rails
  end
  
  def call(env) # env trás os dados referentes a requisição
    status, headers, response = @app.call(env) 
        
    headers.merge!({'X-App-Name' => 'Notebook API'})
    [status, headers, [response.body]]
    # @app.call(env) => chama a aplicação enviando os dados da requisição, retorna um array com as 3 opções (status code, content-type e body)
    # o merge está pegando esse herder que estamos passando e juntando aos já existentes
  end
 end