class AddSelectToDoctors < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :select, :integer
  end
end
