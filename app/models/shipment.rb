class Shipment < ApplicationRecord
  validates :cart_id, :product_id, presence: true, numericality: {only_integer: true}
  validates :quantity, presence: true, numericality: {only_integer: true}
  
  belongs_to :cart
  belongs_to :product
end