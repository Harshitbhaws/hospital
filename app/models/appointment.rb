class Appointment < ApplicationRecord

    belongs_to :user
    belongs_to :doctor, class_name: "User"

    validates :name, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :date, presence: true
    validates :disease, presence: true
    validates :text, presence: true

    def confirm!
        update(confirmation: true)
    end
end
