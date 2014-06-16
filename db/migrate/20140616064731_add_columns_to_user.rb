class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :desc, :text
    add_column :users, :retailer_approval, :boolean
  end
end
