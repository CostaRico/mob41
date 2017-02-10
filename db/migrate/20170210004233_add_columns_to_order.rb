class AddColumnsToOrder < ActiveRecord::Migration[5.0]
  def change
  	add_column :spree_addresses, :comment, :text, :default => ""
  	add_column :spree_addresses, :payment_type_id, :string 
  	add_column :spree_addresses, :delivery_type_id, :string 
  end
end
