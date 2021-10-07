class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :name
      t.integer :phone
      t.string :address
      t.date :date
      t.string :disease
      t.string :text

      t.timestamps
    end
  end
end
