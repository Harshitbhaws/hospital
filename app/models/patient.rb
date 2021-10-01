class Patient < ApplicationRecord

    validates :name, presence: true
    validates :phone, presence: true
    validates :age, presence: true
    validates :address, presence: true
    validates :disease, presence: true
end
