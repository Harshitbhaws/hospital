class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = current_user.appointments.new(appointments_params)

    if @appointment.save!
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.update(appointments_params)
      redirect_to @appointment
    else
      render :edit
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointment_path
  end
  def my_appointments
    @appointments = current_user.appointments
  end

  def todays_appointments
    @todays_appointments = Appointment.where(user_id: current_user.id,date: Date.today)
  end

  private
  def appointments_params
    params.require(:appointment).permit(:name, :phone, :address, :date, :disease, :text, :user_id)
  end
end
