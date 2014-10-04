class ChangeUserToUseOmniAuthFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :first_name
      t.remove :last_name
      t.rename :full_name, :name
    end
  end
end
