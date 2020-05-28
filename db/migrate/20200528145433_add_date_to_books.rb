class AddDateToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :date, :datetime
  end
end
