class ChangeCustomersToMembers < ActiveRecord::Migration[6.1]
  def change
    rename_table :customers, :members
  end
end
