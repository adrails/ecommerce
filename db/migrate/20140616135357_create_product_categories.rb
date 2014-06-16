class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :prod_name

      t.timestamps
    end
  end
end
