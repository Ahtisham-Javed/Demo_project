class ChangeStatusDefaultToFalseForShipments2 < ActiveRecord::Migration[6.0]
  def change
    change_column_default :shipments, :status, from: true, to: false
  end
end
