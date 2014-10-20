class AddSlugToPool < ActiveRecord::Migration
  def change
    add_column :pools, :slug, :string
    add_index :pools, :slug, unique: true
  end
end
