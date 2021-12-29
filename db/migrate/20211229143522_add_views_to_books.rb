class AddViewsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :views, :integer, default: 0
  end
end
