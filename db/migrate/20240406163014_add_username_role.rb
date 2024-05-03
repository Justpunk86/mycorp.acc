class AddUsernameRole < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :role_id, :integer

    add_index :users, :username, unique: true
  end
end
