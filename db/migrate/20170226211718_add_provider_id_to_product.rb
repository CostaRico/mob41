class AddProviderIdToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :spree_products, :provider_id, :integer
  	add_column :spree_products, :from_index, :boolean
  end
end
