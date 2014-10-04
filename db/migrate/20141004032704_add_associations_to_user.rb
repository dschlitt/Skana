class AddAssociationsToUser < ActiveRecord::Migration
  def change
    add_column :seen_users, :user_id, :integer
    add_column :pool_profiles, :user_id, :integer
    add_column :pool_profiles, :pool_id, :integer
    
    create_table :pods_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :pod
    end
  end
end
