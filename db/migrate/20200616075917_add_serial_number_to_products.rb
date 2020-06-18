class AddSerialNumberToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :serial_number, :string, unique: true
  end
end
