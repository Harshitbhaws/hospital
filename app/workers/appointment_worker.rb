class AppointmentWorker
  include Sidekiq::Worker

  def perform(appointment_id,user_id)
    # Do something
    appointment = Appointment.find(appointment_id)
    user = User.find(user_id)
    wb = xlsx_package.workbook
    wb.add_worksheet(name: "Appointments") do |sheet|
      # this is the head row of your spreadsheet
      sheet.add_row %w(name phone address date disease text doctor_id)
      
      # each user is a row on your spreadsheet
      @appointments.each do |appointment|
        sheet.add_row [user.name, user.phone, user.address, user.date, user.disease, user.text, user.doctor_id]
      end
    end
    xlsx_package.serialize("appointment_#{DateTime.now}.xlsx")
  end
end
