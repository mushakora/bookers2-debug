class RenameNameClumnToDirectMessages < ActiveRecord::Migration[5.2]
  def change
  	  rename_column :direct_messages, :name, :message
  end
end
