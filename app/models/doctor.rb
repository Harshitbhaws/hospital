class Doctor < ApplicationRecord
    has_many :appointments
    enum role: { 'confirmation': 0, 'reject': 1}  
    validates :name, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :specialization, presence: true
    def confirmation?
        role == "confirmation"
      end
    
      def reject?
        role == "reject"
      end
      
end