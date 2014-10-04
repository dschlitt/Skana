class CreateSeenUsers < ActiveRecord::Migration
  def change
    create_table :seen_users do |t|
      t.boolean :right_swipe, default: false
    end
  end
end
