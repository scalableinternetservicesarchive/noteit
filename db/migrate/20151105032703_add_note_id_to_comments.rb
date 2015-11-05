class AddNoteIdToComments < ActiveRecord::Migration
  def change
	add_column :comments, :note_id, :integer
  end
end
