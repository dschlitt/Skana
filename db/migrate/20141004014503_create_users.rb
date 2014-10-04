class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :email
      t.datetime :birth_date
      t.text :about
      t.timestamps
    end
  end
end
