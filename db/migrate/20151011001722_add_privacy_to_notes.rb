class AddPrivacyToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :isPrivate, :boolean
  end
end
