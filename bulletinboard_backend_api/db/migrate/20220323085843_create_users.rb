class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :user_type, default: 1
      t.string :phone, null: false
      t.string :address, null: false
      t.datetime :dob, null: false
      t.integer :updated_user_id
      t.integer :deleted_user_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :users, :deleted_at
  end
end
