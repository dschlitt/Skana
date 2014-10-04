class CreatePoolProfiles < ActiveRecord::Migration
  def change
    create_table :pool_profiles do |t|
      t.text :goals
      t.text :skills
      t.timestamps
    end
  end
end
