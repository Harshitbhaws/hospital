class Doctor < ApplicationRecord

    validates :name, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :specialization, presence: true

end