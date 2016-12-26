class AddColumnBrandToProducts < ActiveRecord::Migration[5.0]
  def change
  	add_column :spree_products, :brand, :string, default: "" 
  end
end
