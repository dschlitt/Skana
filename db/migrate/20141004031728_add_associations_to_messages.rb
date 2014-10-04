class AddAssociationsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :pod_id, :integer
  end
end
