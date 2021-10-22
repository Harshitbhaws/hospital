class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.string :from_name
      t.string :from_address
      t.string :from_disease
      t.string :from_phone
      t.string :from_date
      t.string :to_name
      t.string :to_address
      t.string :to_disease
      t.string :to_phone
      t.string :to_date
      t.string :status

      t.timestamps
    end
  end
end
