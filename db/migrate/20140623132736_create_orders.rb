class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
			t.integer :cart_id
			t.float :amount_paid
			t.integer :address_id
			t.string :ip
			t.string :first_name
			t.string :last_name
			t.string :credit_card_no
			t.string :card_type
			t.string :expiry_month
			t.string :expiry_year
			t.string :cvv
      t.timestamps
    end
  end
end
