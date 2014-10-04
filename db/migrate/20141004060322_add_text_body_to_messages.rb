class AddTextBodyToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :text_body, :text
  end
end
