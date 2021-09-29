class CreateDoctor < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.integer :phone
      t.string :address
      t.string :specialization

      t.timestamps
    end
  end
end
