class AddTagsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :tags, :string
  end
end
