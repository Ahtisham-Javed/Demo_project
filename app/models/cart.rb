class Cart < ApplicationRecord
  validates :user_id, presence: true, uniqueness: true
  
  belongs_to :user
  has_many :shipments, dependent: :destroy
  has_many :products, through: :shipments
end