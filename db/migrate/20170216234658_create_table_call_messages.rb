class CreateTableCallMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_call_messages do |t|
    	t.string :name, null: false
    	t.string :phone, default: ""
    	t.text :comment, :default => ""
    end
  end
end
