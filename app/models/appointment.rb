class Appointment < ApplicationRecord

    belongs_to :user
    belongs_to :doctor, class_name: "User"
    enum state: { 'confirmation': 0, 'rejected': 1}  
    validates :name, presence: true, length: {minimum: 2} 
    validate :presence_of_name
    validates :phone, presence: true, format: { with: /\A(\+91)?[1-9][0-9]{9}\z/, message: "does not have a valid format" }
    
    validates :address, presence: true, length: {maximum: 100}
    validates :date, presence: true
    validate :must_have_valid_future_date
    validates :disease, presence: true
    validate :disease_name
    validates :text, presence: true, length: { maximum: 500}
    validate :text_description
    def confirmation!
        update(confirmation: true)
    end

    def rejected!
        update(rejected: true)
    end

    def presence_of_name
        errors.add("name can't be blank") unless name.present?
    end

    def phone_is_unique
        return errors.add(
          :phone, 'Sorry, an account with that phone number already exists.'
        ) unless User.find_by(
          phone: PhonyRails.normalize_number(phone)
        ).nil?
    end

    def must_have_valid_future_date
        if date.present?
            unless date.is_a?(Date)
                errors.add(:date, "must be a valid date")
            end
    
            if date < Date.today
                errors.add(:date, "can't be in the past")
            end
        end
    end
    def disease_name
        errors.add(:disease, "Disease name can't be blank") unless disease.present?
    end

    def text_description
        errors.add(:text, "Text dexcription can't be blank") unless text.present?
    end
end
