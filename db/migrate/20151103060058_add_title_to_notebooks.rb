class AddTitleToNotebooks < ActiveRecord::Migration
  def change
    add_column :notebooks, :title, :string
  end
end
