module V2  
  class AddressesController < ApplicationController
    before_action :set_contact

    # GET /contacts/1/address
    def show
      render json: @contact.address # Pega o contact e acessa o address dele e exibe
    end

    # POST /contacts/1/address
    def create
      @contact.address = Address.new(address_params)

      if @contact.address.save
        render json: @contact.address, status: :created, location: contact_address_url(@contact) # o location vai exibir a url desse elemento no header que vai retornar
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH or PUT /contacts/1/address
    def update
      if @contact.address.update(address_params)
        render json: @contact.address
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1/address
    def destroy
      @contact.address.destroy # Pega o contact e acessa o address dele e apaga
    end

    private
    
    def set_contact
      @contact = Contact.find(params[:contact_id]) #Pois só temos uma rota apontando para cá, pois criamos apenas o model dele, e agora só foi necessário criar o controller para se adequar ao JSON:API
    end

    def address_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  end
end