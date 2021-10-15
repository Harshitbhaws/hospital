class AddRejectToAppointment < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :reject, :boolean, default: false
  end
end
