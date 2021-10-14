class AppointmentMailer < ApplicationMailer
    def send_email(appointment,user)
        @user = user
        @appointment = appointment
        mail(to: @user.email, subject: 'Appointment booked successfully')
    end
    def confirm_appointment(appointment,user)
        @user = user
        @appointment = appointment
        mail(to: @user.email, subject: 'Appointment confirmed successfully')
    end
end
