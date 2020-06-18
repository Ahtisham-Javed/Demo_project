class Product < ApplicationRecord
  has_many_attached :product_images
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :shipments
  has_many :carts, through: :shipments

end
