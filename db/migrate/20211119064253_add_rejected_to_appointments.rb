class AddRejectedToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :rejected, :boolean, default :false
  end
end
