class ChangeAvailabilityDefaultToTrue2 < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :products, :availability, from: false, to: true
  end
end
