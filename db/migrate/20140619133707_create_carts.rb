class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :product_item_ids

      t.timestamps
    end
  end
end
