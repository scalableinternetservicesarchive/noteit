class AddNotebookToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :notebook, index: true, foreign_key: true
  end
end
