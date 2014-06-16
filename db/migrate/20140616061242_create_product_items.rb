class CreateProductItems < ActiveRecord::Migration
  def change
    create_table :product_items do |t|
      t.string :title
      t.integer :available_quantity
      t.string :description
      t.float :price
      t.integer :user_id
      t.boolean :is_active

      t.timestamps
    end
  end
end
