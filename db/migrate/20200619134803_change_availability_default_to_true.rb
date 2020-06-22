class ChangeAvailabilityDefaultToTrue < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :products, :availability, to: false
  end
end
