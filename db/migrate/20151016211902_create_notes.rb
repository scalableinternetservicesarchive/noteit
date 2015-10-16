class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
		t.string :title
		t.string :content
   	  	t.integer :upvotes
      	t.integer :downvotes

		t.string :university
		t.string :professor
		t.string :class_subject
		t.integer :class_number

		t.integer :privacy_level

      	t.timestamps null: false
    end
  end
end
