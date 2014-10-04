class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.timestamps
    end
  end
end
