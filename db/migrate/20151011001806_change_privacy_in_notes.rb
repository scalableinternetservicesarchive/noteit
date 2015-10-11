class ChangePrivacyInNotes < ActiveRecord::Migration
  def change
	remove_column :notes, :isPrivate
	add_column :notes, :privacy_level, :integer
  end
end
