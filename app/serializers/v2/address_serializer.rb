module V2
  class AddressSerializer < ActiveModel::Serializer
    attributes :id, :street, :city

    belongs_to :contact do # singular (pois é apenas um)
      link(:related) { v2_contact_address_url(object.contact.id) } # object.contact.id => acessa o id do contato dentro do objeto atual (address)
    end
  end
end