class AppointmentWorker
  include Sidekiq::Worker

  def perform(appointment_id,user_id)
    # Do something
    appointment = Appointment.find(appointment_id)
    user = User.find(user_id)
    # html_string = AppointmentsController.renderer.render(
    # file: "appointments/show",
    # :formats => [:pdf,:html],
    # locals: {
    #   :@routing_form => self,
    #   :controller_name => appointments_controller,
    #   :action_name => download_appointment,
    #   :current_user => current_user
    # },
    #   :layout  => '/layouts/application'
    # )
    wb = xlsx_package.workbook
    wb.add_worksheet(name: "Appointments") do |sheet|
      # this is the head row of your spreadsheet
      sheet.add_row %w(name phone address date disease text doctor_id)
      
      # each user is a row on your spreadsheet
      @appointments.each do |appointment|
        sheet.add_row [user.name, user.phone, user.address, user.date, user.disease, user.text, user.doctor_id]
      end
    end
  #   respond_to do |format|
  #     format.html
  #     format.pdf do
  #         render pdf: "Invoice No. #{appointment_id}",
  #         page_size: 'A4',
  #         template: "appointments/show.html.erb",
  #         layout: "pdf.html",
  #         orientation: "Landscape",
  #         lowquality: true,
  #         zoom: 1,
  #         dpi: 75
  #     end
  # # end
  #   view = html = ActionView::Base.new(Rails.root.join('app/views'))
  #   view.class.include ApplicationHelper
  #   view.class.include Rails.application.routes.url_helpers
  
  #   rendered = view.render(
  #     :template => "appointments/show.html.erb",
  #     :layout => "layouts/pdf.html.erb",
  #     :locals => { :@appointment => appointment}
  #   )
  #   pdf = WickedPdf.new.pdf_from_string(rendered)
  #   save_path = Rails.root.join('public', 'appointment.pdf')
  #   File.open(save_path, 'wb') do |file|
  #     file << pdf
  #   end
  #     save_path
  end
end
