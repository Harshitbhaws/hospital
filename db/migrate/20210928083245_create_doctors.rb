class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
    create_table :patient do |t|
      t.belongs_to :doctors
      t.timestamps
    end
  end
end
