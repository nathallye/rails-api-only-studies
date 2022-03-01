class Phone < ApplicationRecord
  # pertence a
  belongs_to :contact, optional: true
end
