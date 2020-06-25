class SetSerialNumberToUniqueForProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :serial_number, :string, unique: true, null: false
  end
end
