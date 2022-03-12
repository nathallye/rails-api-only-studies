class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  # before_filter (antes de fazer qualquer coisa na aplicação, rode esse método - ensure_json_request)
  before_action :ensure_json_request 

  def ensure_json_request
    unless request.headers["Accept"] =~ /vnd\.api\+json/ # Verifica os headers que chegam na requisição, e verifica se chegou o header chamado Accept e se dentro dele tem algo chamado /json/;
    # Se vier ele deixa a requisição seguir;
      render :nothing => true, :status => 406 # caso não venha ele devolve o corpo da mensagem em brando e retorna o status code 406
    else
      unless request.get? # ao menos que a requisição não seja get
        return if request.headers["Content-Type"] =~ /vnd\.api\+json/ 
        render :nothing => true, :status => 415
      end
    end
  end
  
end
