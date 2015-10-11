class AddTagsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :university, :string
    add_column :notes, :class_subject, :string
    add_column :notes, :class_number, :integer
    add_column :notes, :professor, :string
  end
end
