class Appointment < ApplicationRecord

    belongs_to :user
    belongs_to :doctor, class_name: "User"
    enum state: { 'confirm': 0, 'rejected': 1}  
    validates :name, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :date, presence: true
    validates :disease, presence: true
    validates :text, presence: true

    def confirm!
        update(confirm: true)
    end

    def rejected!
        update(rejected: true)
    end
end
