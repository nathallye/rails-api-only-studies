class PhonesController < ApplicationController
  before_action :set_contact

  # GET /contacts/1/phones
  def show
    render json: @contact.phones
  end

  # POST /contacts/1/phone
  def create
    @contact.phones << Phone.new(phone_params)

    if @contact.save
      render json: @contact.phones, status: :created, location: contact_phones_url(@contact) # o location vai exibir a url desse elemento no header que vai retornar
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH or PUT /contacts/1/phone
  def update
    phone = Phone.find(phone_params[:id]) # a variável vai receber o phone de acordo com o seu id

    if phone.update(phone_params)
      render json: @contact.phones
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1/phone
  def destroy
    phone = Phone.find(phone_params[:id])
    phone.destroy # Pega o contact e acessa o phone dele e apaga
  end


  private
  
  def set_contact
    @contact = Contact.find(params[:contact_id]) #Pois só temos uma rota apontando para cá, pois criamos apenas o model dele, e agora só foi necessário criar o controller para se adequar ao JSON:API
  end

  def phone_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end