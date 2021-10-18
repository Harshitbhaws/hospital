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
      AppointmentMailer.send_email(@appointment,current_user).deliver_now
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
    redirect_to my_appointments_path
  end

  def my_appointments
    @appointments = current_user.appointments.paginate(:page => params[:page], :per_page=>5)
  end

  def todays_appointments
    @todays_appointments = Appointment.where(doctor_id: current_user.id,date: Date.today).paginate(:page => params[:page], :per_page=>5)
  end

  def approved_appointments
    @approved_appointments = Appointment.where(doctor_id: current_user.id,confirmation: true).paginate(:page => params[:page], :per_page=>5)
  end

  def rejected_appointments
    @rejected_appointments = Appointment.where(doctor_id: current_user.id,reject: true).paginate(:page => params[:page], :per_page=>5)
  end

  def all_appointments
    @all_appointments = Appointment.where(doctor_id: current_user.id).paginate(:page => params[:page], :per_page=>5)
  end

  def  confirmation
    @appointment = Appointment.find(params[:id])
    if @appointment.confirm!
    AppointmentMailer.confirm_appointment(@appointment,current_user).deliver_now
    redirect_to todays_appointments_path
    end
  end

  def  reject
    @appointment = Appointment.find(params[:id])
    if @appointment.reject!
    AppointmentMailer.reject_appointment(@appointment,current_user).deliver_now
    redirect_to todays_appointments_path
    end
  end

  private
  def appointments_params
    params.require(:appointment).permit(:name, :phone, :address, :date, :disease, :text, :doctor_id)
  end
end
