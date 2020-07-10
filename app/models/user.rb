class User < ApplicationRecord
  attr_accessor :delete_user_avatar

  validates :name, presence: true
  validates :address, presence: true

  after_create -> { create_cart id }
  before_update :delete_avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_avatar  
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :cart, dependent: :destroy

  private

    def create_cart(id)
      @cart = Cart.new(user_id: id)
      unless @cart.save
        self.destroy
      end
    end   
 
    def delete_avatar
      if delete_user_avatar == "1"
        user_avatar.purge_later
      end
    end
end
