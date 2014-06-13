class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.string :landmark
      t.integer :profile_detail_id
      t.string :nick_name

      t.timestamps
    end
  end
end
