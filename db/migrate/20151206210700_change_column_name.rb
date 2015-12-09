class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :comments, :content, :body
  end
end
