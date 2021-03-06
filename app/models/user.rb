class User < ApplicationRecord
  has_many :appointments
  enum role: { 'doctor': 1, 'patient': 2}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  def doctor?
    role == "doctor"
  end

  def patient?
    role == "patient"
  end
  
end
