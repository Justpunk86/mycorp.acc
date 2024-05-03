class CreateTableRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :role_name, null:false

      t.timestamps
    end

    create_join_table :users, :roles
    add_foreign_key :roles_users, :users
    add_foreign_key :roles_users, :roles
  end
end
