class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :status, default: 1
      t.integer :updated_user_id
      t.integer :deleted_user_id
      t.datetime :deleted_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, :deleted_at
  end
end
