class SetAddressToNotNullForUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :address, false
  end
end
