class User < ApplicationRecord
  has_many :appointments
  enum region: { 'doctor': 1, 'patient': 2}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
end
