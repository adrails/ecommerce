class CreateProductBrands < ActiveRecord::Migration
  def change
    create_table :product_brands do |t|
      t.string :brand_name

      t.timestamps
    end
  end
end
