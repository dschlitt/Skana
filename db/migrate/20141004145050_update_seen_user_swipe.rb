class UpdateSeenUserSwipe < ActiveRecord::Migration
  def change
    rename_column :swipes, :seen_user, :seen_pool_profile_id
  end
end
