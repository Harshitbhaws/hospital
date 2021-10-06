class Appointment < ApplicationRecord
    validates :name, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :date, presence: true
    validates :disease, presence: true
    validates :text, presence: true
end
