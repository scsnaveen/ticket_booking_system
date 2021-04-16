class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

   validates :first_name, presence: true,format: { with: /\A[a-zA-Z]+\z/,message: "Please enter valid first name" }
   validates :last_name,presence: true,format: { with: /\A[a-zA-Z]+\z/,message: "Please enter valid last name" }
   validates :phone_number,numericality: { only_integer: true },presence: true,length: { minimum:6,maximum:10  }

   has_many :payments
   has_many :reservations
   has_one :wallet
end
