class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
		t.string :content
      	t.integer :upvotes
      	t.integer :downvotes

      	t.timestamps null: false
    end
  end
end
