class Contact < ApplicationRecord
  # pertence a
  belongs_to :kind #, optional: true
 
  # tem varios 
  has_many :phones # plural (pois é apenas vários)
  # tem um 
  has_one :address # singular (pois é apenas um)
  
  # accepts_nested_attributes_for => aceita atributos dos phones (já que tem apenas model) 
  # allow_destroy: true => permite apagar phones através de contact
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  # def as_json(options={})
  #   hash_options = super(options)
  #   hash_options[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
  #   hash_options
  # end
  
  # def to_br
  #   {
  #     name: self.name,
  #     email: self.email,
  #     birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?)
  #   }
  # end
  

  # def author
  #   "Nathallye Tabaresu"
  # end
  
  # def kind_description
  #   self.kind.description # Vai pegar a descrição(description) do tipo(kind) do contato atual(representado pelo self -> ele mesmo)
  # end
  

  # def as_json(options={})
  #   super(
  #     root: true,
  #     methods: [:kind_description, :author]
  #     # include: { kind: { only: :description } }
  #   )
  # end

  # def hello
  #   I18n.t('hello')
  # end

  # def i18n
  #   I18n.default_locale
  # end
end
