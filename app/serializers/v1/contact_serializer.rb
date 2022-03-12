module V1  
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :birthdate, :kind_id #, :author
    

    # pertence a
    belongs_to :kind do #, optional: true
      # link(:self) { contact_kind_url(object.id) }
      link(:related) { v1_contact_kind_url(object.id) }
    end
    # tem varios 
    has_many :phones do # plural (pois é apenas vários)
      link(:related) { v1_contact_phones_url(object.id) }
    end 
    # tem um  
    has_one :address do # singular (pois é apenas um)
      link(:related) { v1_contact_address_url(object.id) }
    end

    # link(:self) { contact_url(object.id) } # object.id (apartir do objeto atual vamos pegar o id)
    # link(:kinds) { kind_url(object.kind.id) } # object.kind.id (apartir do objeto atual vamos pegar kind e seu  id)


    # Não recomendado pelo JSON API esse método de add informações extras no JSON usando atributo "virtual"; 
    # recomenda-se utilizar o meta.
    # def author
    #   "Nathallye Tabaresu"
    # end

    meta do
      { author: "Nathallye" }
    end

    def attributes(*args)
      hash_options = super(*args)
      # pt-BR ---> hash_options[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
      hash_options[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
      hash_options
    end
  end
end