require 'rails_helper'

describe V1::ContactsController, type: :controller do # descriação de onde deve ser executado o test e
  it 'request index and return 200 OK' do # descrição
    request.accept = 'application/vnd.api+json' # enviando o header Accept  
    get :index # requisição get na action index
    expect(response.status).to eql(200) # espera(expect) que o que status da resposta(response.status) seja igual(eql) a 200
  end

  # ou podemos usar o helper para buscar o retorno do status code do rails
  
  it 'request index and return 200 OK' do # descrição
    request.accept = 'application/vnd.api+json' # enviando o header Accept  
    get :index # requisição get na action index
    expect(response).to have_http_status(:ok) # espera(expect) que o que status da resposta(response.status) tem o http status code (have_http_status) 200Olímpia
  end

  it 'request index and return 406 Not Acceptable' do # descrição 
    get :index # requisição get na action index
    expect(response.status).to eql(406) # espera(expect) que o que status da resposta(response.status) tem o http status code (have_http_status) 406 que é quando a pessoa não envia o header accept
  end
  
  it 'GET v1/contacts/:id' do
    kind = Kind.create(description: "Amigo")
    contact = Contact.create(name: "Nathallye", email: "nathallyet@gmail.com", birthdate: "05/04/1999", kind: kind) # a variável contact recebe o primeiro contato cadastrado

    request.accept = 'application/vnd.api+json'# enviando o header Accept  
    get :show, params: { id: contact.id } # para fazer o get na action show é necessário passar o params id; por isso, vamos pegar esse params da variável contact.

    response_body = JSON.parse(response.body) # response.body => vamos pegar somente o body da resposta recebida e guardar na variável response_body; e o JSON.parse vai transformar esse body da resposta em um hash, desse modo podemos usar o fetch
    expect(response_body.fetch('data').fetch('id')).to eq(contact.id.to_s) # vai pegar o nó data do body e em seguida, pega o nó id de dentro de data e compara se o ida é igual ao que foi enviado.
    expect(response_body.fetch('data').fetch('type')).to eq('contacts')
  end 
end
