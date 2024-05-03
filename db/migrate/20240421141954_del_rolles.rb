class DelRolles < ActiveRecord::Migration[7.0]
  def change
    drop_table :rolles
  end
end
