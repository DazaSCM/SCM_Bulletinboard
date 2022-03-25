class AddCreatedUserIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :created_user_id, :integer
  end
end
