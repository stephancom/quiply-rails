class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :old_id, null: false, index: { unique: true }
      t.integer :order_num, null: false
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
    add_foreign_key :orders, :users, primary_key: :old_id
  end
end
