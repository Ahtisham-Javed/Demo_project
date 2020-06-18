class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_avatar  
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :cart, dependent: :destroy

end
