class AddCountToSwipes < ActiveRecord::Migration
  def change
    add_column :swipes, :count, :integer, default: 0
  end
end
