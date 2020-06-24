class ChangeStatusDefaultToFalseForShipments < ActiveRecord::Migration[6.0]
  def change
    change_column_default :shipments, :status, to: false
  end
end
