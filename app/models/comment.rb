class Comment < ActiveRecord::Base
	validates :body, presence: true 
	belongs_to :note
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
end
