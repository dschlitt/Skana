class AddPoolIdToPods < ActiveRecord::Migration
  def change
    add_column :pods, :pool_id, :integer
  end
end
