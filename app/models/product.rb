class Product < ApplicationRecord
  validates :title, presence: true, length: { in: 5..30 }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true

  after_create :generate_serial_number

  has_many_attached :product_images
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :shipments, dependent: :destroy
  has_many :carts, through: :shipments

  def resize_image input
  	self.product_images[input].variant(resize_to_limit: [500,500]).processed
  end

  private
    def generate_serial_number
      update(serial_number: "PLN-#{id}")
    end
end