class AddFieldsToPools < ActiveRecord::Migration
  def change
    change_table :pools do |t|
      t.integer :creator_id
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.string :location_name
      t.string :location_address
    end
  end
end
