class AppointmentWorker
  include Sidekiq::Worker

  def perform(download_appointments_path)
    # Do something
    @appointment.download_appointments(download_appointments_path)
  end
end
