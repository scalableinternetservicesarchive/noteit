class AddAttachmentAvatarToNotes < ActiveRecord::Migration
  def self.up
    change_table :notes do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :notes, :avatar
  end
end
