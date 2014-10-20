class AddDeletedAtToPods < ActiveRecord::Migration
  def change
    add_column :pods, :deleted_at, :datetime
    add_index :pods, :deleted_at
  end
end
