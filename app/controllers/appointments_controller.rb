class AppointmentsController < ApplicationController
  before_action :if_doctor, only: [:confirmation, :reject]

  def index
    @appointments = Appointment.all
    @heading = "Appointments"
    respond_to do |format|
      format.html
      format.xlsx
    end
    if params[:state] == "today"
      @heading = "Todays Appointments"
      @appointments = Appointment.where(doctor_id: current_user.id,date: Date.today).paginate(:page => params[:page], :per_page=>5)
    elsif params[:state] == "approved"
      @heading = "Approved Appointments"
      if current_user.doctor?
        @appointments = Appointment.where(doctor_id: current_user.id,confirmation: true,reject: false).paginate(:page => params[:page], :per_page=>5)
      else
        @appointments = current_user.appointments.where(confirmation: true,reject: false).paginate(:page => params[:page], :per_page=>5) 
      end
    elsif params[:state] == "rejected"
      @heading = "Rejected appointments"
      if current_user.doctor?
        @appointments = Appointment.where(doctor_id: current_user.id,rejected: true).paginate(:page => params[:page], :per_page=>5)
      else
        @appointments = current_user.appointments.where(rejected: true).paginate(:page => params[:page], :per_page=>5) 
      end
    elsif params[:state] == "all"
        @heading = "All Appointments"
        @appointments = Appointment.where(doctor_id: current_user.id).paginate(:page => params[:page], :per_page=>5)
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render template: "appointments/show.html.erb",

          pdf: "Appointment ID: #{@appointment.id}"
      end
    end
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
    if current_user.role == "patient"
      @appointments = current_user.appointments.paginate(:page => params[:page], :per_page=>5)
    else
      "You are not authenticate person for this action"
    end
  end

  # def todays_appointments
  #   @todays_appointments = Appointment.where(doctor_id: current_user.id,date: Date.today).paginate(:page => params[:page], :per_page=>5)
  # end

  # def all_appointments
  #   @all_appointments = Appointment.where(doctor_id: current_user.id).paginate(:page => params[:page], :per_page=>5)
  # end

  # def approved_appointments
  #   if current_user.doctor?
  #     @approved_appointments = Appointment.where(doctor_id: current_user.id,confirmation: true).paginate(:page => params[:page], :per_page=>5)
  #   else
  #     @approved_appointments = current_user.appointments.where(confirmation: true).paginate(:page => params[:page], :per_page=>5) 
  #   end
  # end

  # def rejected_appointments
  #   if current_user.doctor?
  #     @rejected_appointments = Appointment.where(doctor_id: current_user.id,rejected: true).paginate(:page => params[:page], :per_page=>5)
  #   else
  #     @rejected_appointments = current_user.appointments.where(rejected: true).paginate(:page => params[:page], :per_page=>5) 
  #   end
  # end

  def  confirmation
    # if current_user.role == "doctor"
      @appointment = Appointment.find(params[:id])
      if @appointment.confirmation!
        AppointmentMailer.confirm_appointment(@appointment,current_user).deliver_now
        redirect_to appointments_path
      end
    # else
      # redirect_to new_user_session_path
      # "You are not aunthenticate person for this action"
    # end
  end

  def  reject
    # if current_user.role == "doctor"
      @appointment = Appointment.find(params[:id])
      if @appointment.rejected!
        AppointmentMailer.reject_appointment(@appointment,current_user).deliver_now
        redirect_to appointments_path
      end
    # else
      # redirect_to new_user_session_path
      # "You are not aunthenticate person for this action"
    # end
  end

  def export_appointments
    AppointmentWorker.perform_async(params[:id],current_user.id)
    # send_data generate_pdf(@appointments),filename: "#{current_user.name}.pdf",type: "application/pdf"
  end

  private
  def appointments_params
    params.require(:appointment).permit(:name, :phone, :address, :date, :disease, :text, :doctor_id)
  end

  def if_doctor
    redirect_to new_user_session_path unless current_user.role == "doctor"
  end
end
