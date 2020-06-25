class SetSerialNumberToNullableForProducts < ActiveRecord::Migration[6.0]
  def change
    change_column_null :products, :serial_number, :string, from: false, to: true
  end
end
