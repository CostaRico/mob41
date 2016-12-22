class AddCodeToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :spree_products, :code, :integer
  end
end
