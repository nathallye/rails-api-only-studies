class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate, :kind_id

  # pertence a
  belongs_to :kind #, optional: true
  # tem varios 
  has_many :phones # plural (pois é apenas vários)
  # tem um  
  has_one :address # singular (pois é apenas um)

  def attributes(*args)
    hash_options = super(*args)
    # pt-BR ---> hash_options[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    hash_options[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    hash_options
  end
end
