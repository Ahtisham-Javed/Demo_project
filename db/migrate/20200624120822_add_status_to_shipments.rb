class AddStatusToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :status, :boolean
  end
end
