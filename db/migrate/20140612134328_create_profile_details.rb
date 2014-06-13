class CreateProfileDetails < ActiveRecord::Migration
  def change
    create_table :profile_details do |t|
			t.string :contact_no
      t.string :gender
      t.string :dob
			t.string :doj
      t.integer :user_id
			
      t.timestamps
    end
  end
end
