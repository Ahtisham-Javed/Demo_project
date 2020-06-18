class Cart < ApplicationRecord  
  belongs_to :user
  has_many :shipments
  has_many :products, through: :shipments
end
