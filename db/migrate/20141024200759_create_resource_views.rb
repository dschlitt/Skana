class CreateResourceViews < ActiveRecord::Migration
  def change
    create_table :resource_views do |t|
      t.integer :viewable_id
      t.string :viewable_type
      t.belongs_to :user
      t.string :resource_type
      t.datetime :last_viewed_at

      t.timestamps
    end
  end
end
