class KindsController < ApplicationController
  # Para o usar a Auth HTTP Basic 
  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # http_basic_authenticate_with name: "nath", password: "secret"

  # Para o usar a Auth HTTP Digest 
  # include ActionController::HttpAuthentication::Digest::ControllerMethods
  # REALM = "Application"
  # USERS = {"nath" => OpenSSL::Digest::MD5.hexdigest(["nath", REALM, "secret"].join(":"))}  
  # before_action :authenticate

  # Para o usar o token authentication
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # TOKEN = "secret123" # O ideal é que esse token seja gerado em um model de login ou algon assiM
  # before_action :authenticate

  # Para usar o JWT
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authenticate

  
  # Para usar o Devise Token Auth
  # before_action :authenticate_user! #método do Devise

  before_action :set_kind, only: [:show, :update, :destroy]

  # GET /kinds
  def index
    @kinds = Kind.all

    render json: @kinds
  end

  # GET /kinds/1
  def show
    render json: @kind
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_kind
    if params[:contact_id]
      kind_id = Contact.find(params[:contact_id]).kind_id
    else
      kind_id = Contact.find(params[:id]).id
    end
    @kind = Kind.find(kind_id)
  end

  # Only allow a list of trusted parameters through.
  def kind_params
    params.require(:kind).permit(:description)
  end

  # Para o usar a Auth HTTP Digest 
  # def authenticate
  #   authenticate_or_request_with_http_digest(REALM) do |username|
  #     USERS[username]
  #   end
  # end

  # Para o usar o token authentication
  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
  #   end
  # end

  # Para o usar o JWT
  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     hmac_secret = 'my$ecretK3y'

  #     JWT.decode(token, hmac_secret, true, { :algorithm => 'HS256' })
  #   end
  # end
end
