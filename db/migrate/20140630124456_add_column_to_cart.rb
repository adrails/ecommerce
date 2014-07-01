class AddColumnToCart < ActiveRecord::Migration
  def change
    add_column :carts, :quantity, :string
    add_column :carts, :total, :float
  end
end
