class AddColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :retailer_approve, :boolean
    add_column :orders, :admin_approve, :boolean
    add_column :orders, :shipped_approve, :boolean
    add_column :orders, :product_ids, :string
  end
end
