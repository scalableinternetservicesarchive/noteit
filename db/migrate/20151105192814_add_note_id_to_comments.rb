class AddNoteIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :note, index: true, foreign_key: true
  end
end
