class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, force: true do |t|
      t.integer :old_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
