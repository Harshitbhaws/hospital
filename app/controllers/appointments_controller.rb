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
    @appointment = Appointment.new(appointments_params)

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
  private
  def appointments_params
    params.require(:appointment).permit(:name, :phone, :address, :date, :disease, :text)
  end
end
