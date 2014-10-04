class ChangeSeenUsersToSwipes < ActiveRecord::Migration
  def change
    rename_table :seen_users, :swipes
    add_column :swipes, :seen_user, :integer
    add_column :swipes, :pool_id, :integer
  end
end
