class AddConfirmationToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :confirmation, :boolean, default: false
  end
end
