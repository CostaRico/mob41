class CreateTableSpreeProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_providers do |t|
    	t.string :name
    	t.text :description
    	t.boolean :active
    end
  end
end
