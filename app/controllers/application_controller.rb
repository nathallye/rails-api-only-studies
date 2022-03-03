class ApplicationController < ActionController::API

  # before_filter (antes de fazer qualquer coisa na aplicação, rode esse método - ensure_json_request)
  before_action :ensure_json_request 

  def ensure_json_request
    return if request.headers["Accept"] =~ /vnd\.api\+json/ # Verifica os headers que chegam na requisição, e verifica se chegou o header chamado Accept e se dentro dele tem algo chamado /json/;
    # Se vier ele deixa a requisição seguir;
    render :nothing => true, :status => 406 # caso não venha ele devolve o corpo da mensagem em brando e retorna o status code 406
  end
  
end
