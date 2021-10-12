class UserMailer < ApplicationMailer
    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Appointment booked successfully')
    end
end
