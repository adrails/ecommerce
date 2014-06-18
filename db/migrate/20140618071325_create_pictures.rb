class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
			t.integer :product_item_id
			t.attachment :image
      t.timestamps
    end
  end
end
