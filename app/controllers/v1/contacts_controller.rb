module V1 
  class ContactsController < ApplicationController
    include ErrorSerializer

    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /contacts
    def index
      page_number = params[:page].try(:[], [:number]) # verifica se page tem number, se não tiver atribui 1, se tiver atribui ele
      per_page = params[:page].try(:[], [:size]) # verifica se page tem size, se não tiver atribui 1, se tiver atribui ele

      @contacts = Contact.all.page(page_number).per(per_page) # paginação seguindo a especificação JSON:API via body
      # @contacts = Contact.all.page(params[:page]) # page(params[:page]) => parte do kaminari  - paginação via Header

      # expires_in 2.minutes, public: true # Cache-Control
      if stale?(etag: @contacts) # se venceu a Etag, vai renderizar os contacts
        render json: @contacts #, methods: [:hello, :i18n] 
      end
      # paginate json: @contacts # paginate =>  parte do api-paginate (substitui o render pelo paginate) - paginação via Header
    end

    # GET /contacts/1
    def show
      render json: @contact #, include: [:kind, :phones, :address] #, meta: { author: "Nathallye" }
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [:kind, :phones, :address], status: :created , location: v1_contact_url(@contact)
      else
        render json: ErrorSerializer.serialize(@contact.errors), status: :unprocessable_entity #@contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [:kind, :phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      # params.require(:contact).permit(:name, :email, :birthdate, :kind_id, 
      #   phones_attributes:[:id, :number, :_destroy], 
      #   address_attributes:[:id, :street, :city]
      # )
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  end
end